import 'package:flutter/material.dart';

class CustomOption extends StatelessWidget {
  final String option;
  final Color borderColor;
  final VoidCallback onTap;

  const CustomOption({
    required this.option,
    required this.borderColor,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);

    final screenHeight = screenSize.size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        width: double.infinity,
        height: screenHeight / 18,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 3),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            option,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
