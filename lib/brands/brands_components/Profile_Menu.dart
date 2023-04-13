import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  final String label;
  final VoidCallback onPress;
  const ProfileMenu({super.key, required this.label, required this.onPress});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFDB3022),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Icon(
              Icons.arrow_right,
              color: Colors.white,
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}
