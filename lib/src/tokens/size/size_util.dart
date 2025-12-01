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

  /// Width responsive to design
  double get rw => screen.shortestSide / _designWidth;

  /// Height responsive to design
  double get rh => screen.height / _designHeight;

  /// A safe scale factor (best for padding, font, small UI elements)
  double get scale => rw; // you can use min(rw, rh) if you prefer

  /// Scale any value safely
  double adjust(double value) => value * scale;

  /// Direct screen width/height
  double get width => screen.width;
  double get height => screen.height;
}
