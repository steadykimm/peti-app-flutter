// lib/widgets/section.dart

import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final Widget child;
  final String title;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const Section({
    super.key,
    required this.child,
    required this.title,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
