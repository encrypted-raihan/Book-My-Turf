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

class _PlayerHomeScreenState extends State<PlayerHomeScreen> {
  // Initial State
  String _currentLocation = "Locating..."; 
  String _searchQuery = "";
  String _selectedCategory = "All";
  
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
    _initLocation();
  }

  // --- LOCATION LOGIC ---
  Future<void> _initLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          setState(() => _currentLocation = "Enable location");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Location services are off. Please enable GPS."),
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

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 10),
        ),
      );

      _updateAddress(position);
    } catch (e) {
      debugPrint("Location error: $e");
      if (mounted) {
        setState(() => _currentLocation = "Enable location");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Couldn't access location. Please try again."),
          ),
        );
      }
    }
  }

  Future<void> _updateAddress(Position pos) async {
    // 1. ATTEMPT MOBILE NATIVE (Fastest on Android/iOS)
    if (!kIsWeb) {
      try {
        List<Placemark> p = await placemarkFromCoordinates(pos.latitude, pos.longitude);
        if (p.isNotEmpty && mounted) {
          setState(() {
            String city = p[0].locality ?? p[0].subLocality ?? p[0].subAdministrativeArea ?? "Kollam";
            _currentLocation = "$city, ${p[0].administrativeArea ?? 'Kerala'}";
          });
          return;
        }
      } catch (_) {}
    }

    // 2. ATTEMPT WEB API (Aggressive fallback for "Unknown" issues)
    try {
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${pos.latitude}&lon=${pos.longitude}&zoom=14'
      );
      
      final response = await http.get(url, headers: {'User-Agent': 'TurfBookingApp_v1'});
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final addr = data['address'];
        
        // Cascading check to find ANY valid name for the location
        String city = addr['city'] ?? 
                      addr['town'] ?? 
                      addr['village'] ?? 
                      addr['suburb'] ?? 
                      addr['neighbourhood'] ?? 
                      addr['district'] ?? 
                      "Kollam";
        String state = addr['state'] ?? "Kerala";

        if (mounted) {
          setState(() => _currentLocation = "$city, $state");
        }
      }
    } catch (e) {
      if (mounted) setState(() => _currentLocation = "Kollam, Kerala");
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
          const Icon(Icons.refresh_rounded, color: Colors.white24, size: 12),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: const BorderRadius.all(Radius.circular(10)), // Saved Preference
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: TextField(
        onChanged: (val) => setState(() => _searchQuery = val),
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          icon: Icon(Icons.search, color: Color(0xFFA061FF)),
          hintText: "Search name...",
          hintStyle: TextStyle(color: Colors.white24),
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
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = _categories[index]),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: isSelected ? const LinearGradient(colors: [Color(0xFFA061FF), Color(0xFF7000FF)]) : null,
                color: isSelected ? null : Colors.white.withValues(alpha: 0.05),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: isSelected ? Colors.transparent : Colors.white.withValues(alpha: 0.1)),
              ),
              alignment: Alignment.center,
              child: Text(
                _categories[index],
                style: TextStyle(color: isSelected ? Colors.white : Colors.white38, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPremiumCard(Map<String, String> turf) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const TurfDetailScreen())),
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        height: 280,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: Icon(
                  turf['type'] == "Football" ? Icons.sports_soccer : Icons.sports_cricket,
                  size: 50, color: Colors.white10
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
                      gradient: const LinearGradient(colors: [Color(0xFFA061FF), Color(0xFF7000FF)]),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text("₹${turf['price']}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGlow() {
    return Container(
      width: 300, height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFA061FF).withValues(alpha: 0.1),
        boxShadow: [BoxShadow(color: const Color(0xFFA061FF).withValues(alpha: 0.1), blurRadius: 100, spreadRadius: 50)],
      ),
    );
  }
}
