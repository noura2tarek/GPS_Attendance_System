import 'package:flutter/material.dart';

class CustomDetText extends StatelessWidget {
  const CustomDetText({
    required this.text,
    super.key,
    this.textColor = Colors.black,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor,
        fontWeight: fontWeight,
      ),
    );
  }
}
