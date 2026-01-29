import 'package:flutter/material.dart';

class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String location;
  HomeHeaderDelegate({required this.location});

  @override double get minExtent => 120;
  @override double get maxExtent => 180;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Book My Turf", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.greenAccent, size: 14),
              const SizedBox(width: 4),
              Text(location, style: const TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 15),
          TextField(
            decoration: InputDecoration(
              hintText: "Search turfs...",
              filled: true,
              fillColor: Colors.white10,
              prefixIcon: const Icon(Icons.search, color: Colors.white38),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)), // Preference
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override bool shouldRebuild(covariant HomeHeaderDelegate oldDelegate) => oldDelegate.location != location;
}