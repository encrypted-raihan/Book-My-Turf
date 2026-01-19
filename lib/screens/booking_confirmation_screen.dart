import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final String turfName;
  final String timeSlot;
  final String price;
  final String location;

  const BookingConfirmationScreen({
    super.key,
    required this.turfName,
    required this.timeSlot,
    required this.price,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Booking Confirmed"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // Success icon
            const Center(
              child: Icon(
                Icons.check_circle,
                color: kPrimaryColor,
                size: 80,
              ),
            ),

            const SizedBox(height: 24),

            const Center(
              child: Text(
                "Your booking is confirmed!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: kTextColor,
                ),
              ),
            ),

            const SizedBox(height: 32),

            _infoRow("Turf", turfName),
            _infoRow("Location", location),
            _infoRow("Time Slot", timeSlot),
            _infoRow("Price", price),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Go to Home",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$label:",
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
