import 'dart:ui';
import 'package:flutter/material.dart';
import 'booking_success_screen.dart';

class SlotSelectionScreen extends StatefulWidget {
  const SlotSelectionScreen({super.key});

  @override
  State<SlotSelectionScreen> createState() => _SlotSelectionScreenState();
}

class _SlotSelectionScreenState extends State<SlotSelectionScreen> {
  int? _selectedSlotIndex;

  final List<String> _slots = [
    "06:00 AM", "07:00 AM", "08:00 AM", "09:00 AM",
    "10:00 AM", "11:00 AM", "04:00 PM", "05:00 PM",
    "06:00 PM", "07:00 PM", "08:00 PM", "09:00 PM"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Select Slot", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Background Glow
          Positioned(
            bottom: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFA061FF).withValues(alpha: 0.1),
              ),
              child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80), child: Container()),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Available Slots", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white)),
                const Text("Select your preferred 1-hour session", style: TextStyle(color: Colors.white38)),
                const SizedBox(height: 30),
                
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.8,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _slots.length,
                    itemBuilder: (context, index) {
                      bool isSelected = _selectedSlotIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSlotIndex = index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)), // Saved Preference
                            gradient: isSelected 
                              ? const LinearGradient(colors: [Color(0xFFA061FF), Color(0xFF7000FF)])
                              : null,
                            color: isSelected ? null : Colors.white.withValues(alpha: 0.05),
                            border: Border.all(
                              color: isSelected ? Colors.white24 : Colors.white.withValues(alpha: 0.1)
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _slots[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white70,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                // Bottom Action Area
                _buildBottomAction(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: const BorderRadius.all(Radius.circular(10)), // Saved Preference
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Price", style: TextStyle(color: Colors.white38)),
              Text(
                _selectedSlotIndex != null ? "₹1,200.00" : "₹0.00",
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 65,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedSlotIndex != null ? const Color(0xFFA061FF) : Colors.white12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Saved Preference
            ),
            onPressed: _selectedSlotIndex == null ? null : () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => const BookingSuccessScreen()));
            },
            child: const Text(
              "CONFIRM BOOKING",
              style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}