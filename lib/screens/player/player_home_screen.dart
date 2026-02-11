import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb; 
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http; // Make sure to run: flutter pub add http
import 'turf_detail_screen.dart';

class PlayerHomeScreen extends StatefulWidget {
  const PlayerHomeScreen({super.key});

  @override
  State<PlayerHomeScreen> createState() => _PlayerHomeScreenState();
}

class _PlayerHomeScreenState extends State<PlayerHomeScreen> with SingleTickerProviderStateMixin {
  // Initial State
  String _currentLocation = "Locating..."; 
  String _searchQuery = "";
  String _selectedCategory = "All";
  Position? _lastResolvedPosition;
  String? _lastResolvedLocation;
  DateTime? _lastResolvedAt;
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;
  late final FocusNode _searchFocusNode;
  bool _isSearchFocused = false;
  
  final List<String> _categories = ["All", "Football", "Cricket", "Badminton"];

  final List<Map<String, String>> _allTurfs = [
    {"name": "Super Kickers Arena", "type": "Football", "price": "1500", "dist": "1.2km"},
    {"name": "Star Strike Hub", "type": "Cricket", "price": "1200", "dist": "2.5km"},
    {"name": "Power Play Pro", "type": "Football", "price": "1000", "dist": "3.1km"},
    {"name": "Smash Center", "type": "Badminton", "price": "800", "dist": "0.5km"},
  ];

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
    _glowAnimation = CurvedAnimation(parent: _glowController, curve: Curves.easeInOut);
    _searchFocusNode = FocusNode()
      ..addListener(() {
        if (!mounted) return;
        setState(() => _isSearchFocused = _searchFocusNode.hasFocus);
      });
    _initLocation();
  }

  @override
  void dispose() {
    _glowController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  // --- LOCATION LOGIC ---
  Future<void> _initLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          setState(() => _currentLocation = "Enable location");
          showDialog<void>(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: const Text("Turn on Location Services"),
              content: const Text(
                "Location services are off. Enable GPS to show nearby turfs.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text("Not now"),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(dialogContext).pop();
                    if (!kIsWeb) {
                      await Geolocator.openLocationSettings();
                    }
                  },
                  child: const Text("Open settings"),
                ),
              ],
            ),
          );
        }
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            setState(() => _currentLocation = "Enable location");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Location permission denied. Enable it to show nearby turfs."),
              ),
            );
          }
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          setState(() => _currentLocation = "Enable location");
          showDialog<void>(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: const Text("Enable Location"),
              content: const Text(
                "Location permission is permanently denied. Open settings to enable it.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text("Not now"),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(dialogContext).pop();
                    await Geolocator.openAppSettings();
                  },
                  child: const Text("Open settings"),
                ),
              ],
            ),
          );
        }
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 10),
        ),
      ).catchError((_) => Geolocator.getLastKnownPosition());

      if (position == null) {
        if (mounted) {
          setState(() => _currentLocation = _lastResolvedLocation ?? "Kollam, Kerala");
        }
        return;
      }

      await _updateAddress(position);
    } catch (e) {
      debugPrint("Location error: $e");
      if (mounted) {
        setState(() => _currentLocation = "Enable location");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              kIsWeb
                  ? "Couldn't access location. In Chrome, allow location and run on https or localhost."
                  : "Couldn't access location. Please try again.",
            ),
          ),
        );
      }
    }
  }

  Future<Position?> _resolveCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 10),
        ),
      );
    } catch (_) {
      if (kIsWeb) {
        try {
          return await Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.low,
              timeLimit: Duration(seconds: 15),
            ),
          ).first.timeout(const Duration(seconds: 15));
        } catch (_) {}
      }
      return Geolocator.getLastKnownPosition();
    }
  }

  Future<void> _updateAddress(Position pos) async {
    const cacheDistanceMeters = 50.0;
    const cacheTimeWindow = Duration(minutes: 2);
    final lastPosition = _lastResolvedPosition;
    final lastLocation = _lastResolvedLocation;
    final lastResolvedAt = _lastResolvedAt;
    if (lastPosition != null && lastLocation != null && lastResolvedAt != null) {
      final distance = Geolocator.distanceBetween(
        pos.latitude,
        pos.longitude,
        lastPosition.latitude,
        lastPosition.longitude,
      );
      final timeSinceLast = DateTime.now().difference(lastResolvedAt);
      if (distance < cacheDistanceMeters || timeSinceLast < cacheTimeWindow) {
        if (mounted) setState(() => _currentLocation = lastLocation);
        return;
      }
    }

    // 1. ATTEMPT MOBILE NATIVE (Fastest on Android/iOS)
    if (!kIsWeb) {
      try {
        List<Placemark> p = await placemarkFromCoordinates(pos.latitude, pos.longitude);
        if (p.isNotEmpty && mounted) {
          setState(() {
            String city = p[0].locality ?? p[0].subLocality ?? p[0].subAdministrativeArea ?? "Kollam";
            _currentLocation = "$city, ${p[0].administrativeArea ?? 'Kerala'}";
            _lastResolvedPosition = pos;
            _lastResolvedLocation = _currentLocation;
            _lastResolvedAt = DateTime.now();
          });
          return;
        }
      } catch (_) {}
    }

    // 2. ATTEMPT WEB API (Aggressive fallback for "Unknown" issues)
    try {
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${pos.latitude}&lon=${pos.longitude}&zoom=14&addressdetails=1'
      );

      final response = await http.get(url).timeout(const Duration(seconds: 8));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final addr = (data['address'] as Map<String, dynamic>?) ?? {};

        // Cascading check to find ANY valid name for the location
        String city = (addr['city'] ??
                    addr['town'] ??
                    addr['village'] ??
                    addr['suburb'] ??
                    addr['neighbourhood'] ??
                    addr['county'] ??
                    addr['district'] ??
                    data['name'] ??
                    "Kollam")
                .toString();
        String state = (addr['state'] ?? addr['state_district'] ?? "Kerala").toString();

        if (mounted) {
          setState(() {
            _currentLocation = "$city, $state";
            _lastResolvedPosition = pos;
            _lastResolvedLocation = _currentLocation;
            _lastResolvedAt = DateTime.now();
          });
        }
      } else if (mounted && lastLocation != null) {
        setState(() => _currentLocation = lastLocation);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _currentLocation = lastLocation ?? "Kollam, Kerala");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Combined Search and Category Filtering
    final filteredTurfs = _allTurfs.where((turf) {
      final matchesSearch = turf['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == "All" || turf['type'] == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF09090B),
      body: Stack(
        children: [
          Positioned.fill(child: _buildGradientBackdrop()),
          Positioned(top: -100, right: -50, child: _buildGlow()),
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 70, 25, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLocationHeader(),
                      const SizedBox(height: 12),
                      const Text("Find every", style: TextStyle(color: Colors.white54, fontSize: 16)),
                      const Text("Turf around you", style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: Colors.white)),
                      const SizedBox(height: 25),
                      _buildSearchBox(),
                      const SizedBox(height: 25),
                      _buildCategoryList(),
                    ],
                  ),
                ),
              ),
              
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => _buildPremiumCard(filteredTurfs[i]),
                    childCount: filteredTurfs.length,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildLocationHeader() {
    return InkWell(
      onTap: _initLocation,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on, color: Color(0xFFA061FF), size: 14),
          const SizedBox(width: 4),
          Text(_currentLocation, style: const TextStyle(color: Colors.white38, fontSize: 12)),
          const SizedBox(width: 6),
          const Icon(Icons.refresh_rounded, color: Colors.white38, size: 12),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: _isSearchFocused ? 0.08 : 0.05),
        borderRadius: const BorderRadius.all(Radius.circular(10)), // Saved Preference
        border: Border.all(
          color: _isSearchFocused ? const Color(0xFFA061FF) : Colors.white.withValues(alpha: 0.1),
        ),
        boxShadow: _isSearchFocused
            ? [
                BoxShadow(
                  color: const Color(0xFFA061FF).withValues(alpha: 0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ]
            : [],
      ),
      child: TextField(
        focusNode: _searchFocusNode,
        onChanged: (val) => setState(() => _searchQuery = val),
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          icon: Icon(Icons.search, color: Color(0xFFA061FF)),
          hintText: "Search name...",
          hintStyle: TextStyle(color: Colors.white38),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedCategory == _categories[index];
          return Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              onTap: () => setState(() => _selectedCategory = _categories[index]),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [Color(0xFFA061FF), Color(0xFF7000FF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isSelected ? null : Colors.white.withValues(alpha: 0.05),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: isSelected ? Colors.transparent : Colors.white.withValues(alpha: 0.1)),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFFA061FF).withValues(alpha: 0.25),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  _categories[index],
                  style: TextStyle(color: isSelected ? Colors.white : Colors.white38, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPremiumCard(Map<String, String> turf) {
    final semanticsLabel = "${turf['name']}, ₹${turf['price']}";
    final isFootball = turf['type'] == "Football";
    final cardGradient = LinearGradient(
      colors: [
        const Color(0xFF1B1232).withValues(alpha: 0.55),
        const Color(0xFF09090B).withValues(alpha: 0.95),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    return Semantics(
      button: true,
      label: semanticsLabel,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const TurfDetailScreen())),
          child: Container(
            margin: const EdgeInsets.only(bottom: 25),
            height: 280,
            decoration: BoxDecoration(
              gradient: cardGradient,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          isFootball ? const Color(0xFF26123F) : const Color(0xFF17192B),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                    child: Icon(
                      isFootball ? Icons.sports_soccer : Icons.sports_cricket,
                      size: 54,
                      color: Colors.white12,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(turf['name']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                          Text("${turf['type']} • ${turf['dist']} away", style: const TextStyle(color: Colors.white38)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFA061FF), Color(0xFF7000FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFA061FF).withValues(alpha: 0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Text("₹${turf['price']}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlow() {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        final intensity = 0.08 + (0.07 * _glowAnimation.value);
        return Transform.scale(
          scale: 0.9 + (0.15 * _glowAnimation.value),
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFA061FF).withValues(alpha: intensity),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFA061FF).withValues(alpha: intensity),
                  blurRadius: 120,
                  spreadRadius: 60,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGradientBackdrop() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF120C1F).withValues(alpha: 0.95),
            const Color(0xFF09090B).withValues(alpha: 0.9),
            const Color(0xFF09090B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
