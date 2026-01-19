import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../widgets/time_slot_chip.dart';

class TurfDetailsScreen extends StatefulWidget {
  final String name;
  final String features;
  final String price;
  final String location;
  final double rating;

  const TurfDetailsScreen({
    super.key,
    required this.name,
    required this.features,
    required this.price,
    required this.location,
    required this.rating,
  });

  @override
  State<TurfDetailsScreen> createState() => _TurfDetailsScreenState();
}

class _TurfDetailsScreenState extends State<TurfDetailsScreen> {
  int selectedSlotIndex = -1;

  final List<String> timeSlots = [
    "6:00 - 7:00",
    "7:00 - 8:00",
    "8:00 - 9:00",
    "9:00 - 10:00",
    "10:00 - 11:00",
    "11:00 - 12:00",
  ];

  final List<String> bookedSlots = [
    "7:00 - 8:00",
    "9:00 - 10:00",
  ];

  bool get isSlotSelected => selectedSlotIndex != -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---------------- TURF INFO ----------------
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: kTextColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.features,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.location_on,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(widget.location,
                    style: const TextStyle(color: Colors.grey)),
                const Spacer(),
                const Icon(Icons.star,
                    size: 16, color: Colors.amber),
                const SizedBox(width: 4),
                Text(widget.rating.toString(),
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),

            const SizedBox(height: 28),

            /// ---------------- GLASSMORPHIC SLOT SECTION ----------------
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Time Slot",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: kTextColor,
                        ),
                      ),

                      const SizedBox(height: 12),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: timeSlots.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 2.4,
                        ),
                        itemBuilder: (context, index) {
                          final slot = timeSlots[index];
                          final isBooked = bookedSlots.contains(slot);

                          return TimeSlotChip(
                            time: slot,
                            isSelected: selectedSlotIndex == index,
                            isBooked: isBooked,
                            onTap: () {
                              setState(() {
                                selectedSlotIndex = index;
                              });
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      Text(
                        widget.price,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isSlotSelected ? () {} : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            disabledBackgroundColor:
                                Colors.grey.shade800,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            isSlotSelected
                                ? "Proceed to Pay (${timeSlots[selectedSlotIndex]})"
                                : "Select a time slot",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
