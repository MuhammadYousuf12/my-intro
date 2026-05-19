import 'package:flutter/material.dart';

// Splits comma-separated text into styled chips
class ChipWrap extends StatelessWidget {
  final String text;
  final Color color;

  const ChipWrap({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    final items = text.split(',').map((e) => e.trim()).toList();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Text(
            item,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }
}
