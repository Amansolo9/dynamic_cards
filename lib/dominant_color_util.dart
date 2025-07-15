import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:material_color_utilities/material_color_utilities.dart';

Future<Color> getDominantColor(File imageFile) async {
  final Uint8List bytes = await imageFile.readAsBytes();
  final img.Image? image = img.decodeImage(bytes);
  if (image == null) {
    // Fallback if sth goes wrong while decoding
    return const Color.fromARGB(255, 0, 0, 0);
  }

  // 64 by 64 can give enough estimate to find the dominant color(also performance(faster))
  final img.Image resized = img.copyResize(image, width: 64, height: 64);
  final Map<int, int> colorCount = {};


  //changing the argb to a single int for ease of counting
  for (int y = 0; y < resized.height; y++) {
    for (int x = 0; x < resized.width; x++) {
      final pixel = resized.getPixel(x, y);
      final int argb = (pixel.a.toInt() << 24) | (pixel.r.toInt() << 16) | (pixel.g.toInt() << 8) | pixel.b.toInt();
      colorCount[argb] = (colorCount[argb] ?? 0) + 1;
    }
  }

  // count the most frequent color
  int? dominantColor;
  int maxCount = 0;
  colorCount.forEach((color, count) {
    if (count > maxCount) {
      maxCount = count;
      dominantColor = color;
    }
  });

//equal amount of dominance
  if (dominantColor == null) {
    return const Color.fromARGB(255, 0, 0, 0);
  }

  // change the int to argb
  final int argb = dominantColor!;
  final int a = (argb >> 24) & 0xFF;
  final int r = (argb >> 16) & 0xFF;
  final int g = (argb >> 8) & 0xFF;
  final int b = argb & 0xFF;

  // Used material_color_utilities to get a Material-compliant color but it was returning a weird color(shifted form of the color so i just returned the actual argb)
  final color = Color.fromARGB(a, r, g, b);
  //final int materialColor = CorePalette.of(color.value).primary.get(40);
  //return Color(materialColor);
  return color;
} 