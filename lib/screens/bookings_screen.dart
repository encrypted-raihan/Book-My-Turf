import 'package:flutter/material.dart';
import '../widgets/booking_card.dart';
import '../constants/app_constants.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Toggle this later when backend comes
    final bool hasBookings = false;

    if (!hasBookings) {
      return _emptyState();
    }

    return ListView(
      padding: const EdgeInsets.only(top: 8),
      children: const [
        BookingCard(
          turfName: "Green Valley Turf",
          location: "Kottarakkara",
          date: "Today",
          time: "7:00 - 8:00",
          price: "₹1200",
        ),
      ],
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.event_busy,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              "No bookings yet",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kTextColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Book a turf and your bookings will appear here.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
