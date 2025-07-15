import 'package:flutter/material.dart';
import 'dart:math' as math;

/// using WCAG 2.x relative luminance calculation.
Color getBestFontColor(Color background, {double threshold = 0.5}) {
  double r = ((background.r * 255.0).round() & 0xff) / 255.0;
  double g = ((background.g * 255.0).round() & 0xff) / 255.0;
  double b = ((background.b * 255.0).round() & 0xff) / 255.0;

  // Gamma correction
  r = (r <= 0.03928) ? r / 12.92 : math.pow((r + 0.055) / 1.055, 2.4).toDouble();
  g = (g <= 0.03928) ? g / 12.92 : math.pow((g + 0.055) / 1.055, 2.4).toDouble();
  b = (b <= 0.03928) ? b / 12.92 : math.pow((b + 0.055) / 1.055, 2.4).toDouble();

  // Relative luminance calculated using the formula L = 0.2126 * R_linear + 0.7152 * G_linear + 0.0722 * B_linear
  double L = 0.2126 * r + 0.7152 * g + 0.0722 * b;

  // Return black for light backgrounds, white for dark
  return (L > threshold) ? Colors.black : Colors.white;
}
