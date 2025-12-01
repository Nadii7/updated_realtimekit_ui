import 'package:flutter/material.dart';

// class SizeUtil {
//   final BuildContext context;
//   SizeUtil(this.context);

// }

const double _designHeight = 812;
const double _designWidth = 375;

const appbarHeight = 56.0;
const bottomNavbarHeight = 64.0;

const meetingRoomHeight = _designHeight - appbarHeight - bottomNavbarHeight;

extension SizeUtil on BuildContext {
  Size get screen => MediaQuery.of(this).size;

  // Raw scale based on width
  double get _rawScale => screen.shortestSide / _designWidth;

  // Safe scale (max 1.3) to prevent huge buttons on tablets
  double get scale => _rawScale.clamp(0.8, 1.3);

  // For widths (allowed to stretch more)
  double w(double value) => value * _rawScale;

  // For fixed UI sizes
  double adjust(double value) => value * scale;

  double get width => screen.width;
  double get height => screen.height;
}
