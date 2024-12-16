import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SortButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  SortButton({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Detects button taps
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        margin: EdgeInsets.symmetric(horizontal: 5), // Space between buttons
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF7A6EAE) : Colors.grey[300], // Dynamic background color
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black, // Text color
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
