import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    super.key,
    required this.onpressed,

    required this.color,
    required this.buttonContent,
  });
  final void Function() onpressed;

  final Color color;
  final Widget buttonContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color(0xFFFF3D00), // Bright Red
            Color(0xFFFF6D00), // Orange
            Color(0xFFFF4081), // Pink Accent
            Color(0xFF9C27B0), // Deep Purple
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: buttonContent,
      ),
    );
  }
}
