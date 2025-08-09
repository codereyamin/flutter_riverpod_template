import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/constant/app_colors.dart';

class DottedBorderPainter extends CustomPainter {
  final double cornerRadius;

  DottedBorderPainter({required this.cornerRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.instance.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5; // Width of each dash
    const double dashSpace = 5; // Space between each dash

    // Create a path with rounded corners
    final path = Path()..addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(cornerRadius)));

    // Draw dashes along the rounded path
    double distance = 0.0;
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final extractPath = pathMetric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
      distance = 0.0; // Reset distance for next edge of path
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
