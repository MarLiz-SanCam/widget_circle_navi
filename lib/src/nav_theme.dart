import 'package:flutter/material.dart';

class PillNavBarTheme {
  final Color activeColor;
  final Color inactiveColor;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final double itemSize;
  final double iconSize;
  final double connectorWidth;
  final double connectorHeight;
  final double activeInnerMargin;
  final Duration animationDuration;
  final Curve animationCurve;

  const PillNavBarTheme({
    this.activeColor = Colors.white,
    this.inactiveColor = const Color.fromARGB(255, 151, 7, 31),
    this.activeIconColor = const Color.fromARGB(255, 151, 7, 31),
    this.inactiveIconColor = Colors.white54,
    this.itemSize = 62,
    this.iconSize = 22,
    this.connectorWidth = 14,
    this.connectorHeight = 16,
    this.activeInnerMargin = 9,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOutCubic,
  });

  static const dark = PillNavBarTheme();
}
