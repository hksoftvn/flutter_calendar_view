// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'constants.dart';
import 'enumerations.dart';

/// Paints 24 hour lines.
class HourLinePainter extends CustomPainter {
  /// Color of hour line
  final Color lineColor;

  /// Height of hour line
  final double lineHeight;

  /// Offset of hour line from left.
  final double offset;

  /// Height occupied by one minute of time stamp.
  final double minuteHeight;

  /// Flag to display vertical line at left or not.
  final bool showVerticalLine;

  /// left offset of vertical line.
  final double verticalLineOffset;

  /// Style of the hour and vertical line
  final LineStyle lineStyle;

  /// Line dash width when using the [LineStyle.dashed] style
  final double dashWidth;

  /// Line dash space width when using the [LineStyle.dashed] style
  final double dashSpaceWidth;

  /// Paints 24 hour lines.
  HourLinePainter({
    required this.lineColor,
    required this.lineHeight,
    required this.minuteHeight,
    required this.offset,
    required this.showVerticalLine,
    this.verticalLineOffset = 10,
    this.lineStyle = LineStyle.solid,
    this.dashWidth = 4,
    this.dashSpaceWidth = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineHeight;

    for (var i = 1; i < Constants.hoursADay; i++) {
      final dy = i * minuteHeight * 60;
      if (lineStyle == LineStyle.dashed) {
        var startX = offset;
        while (startX < size.width) {
          canvas.drawLine(
              Offset(startX, dy), Offset(startX + dashWidth, dy), paint);
          startX += dashWidth + dashSpaceWidth;
        }
      } else {
        canvas.drawLine(Offset(offset, dy), Offset(size.width, dy), paint);
      }
    }

    if (showVerticalLine) if (lineStyle == LineStyle.dashed) {
      var startY = 0.0;
      while (startY < size.height) {
        canvas.drawLine(Offset(offset + verticalLineOffset, startY),
            Offset(offset + verticalLineOffset, startY + dashWidth), paint);
        startY += dashWidth + dashSpaceWidth;
      }
    } else {
      canvas.drawLine(Offset(offset + verticalLineOffset, 0),
          Offset(offset + verticalLineOffset, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is HourLinePainter &&
        (oldDelegate.lineColor != lineColor ||
            oldDelegate.offset != offset ||
            lineHeight != oldDelegate.lineHeight ||
            minuteHeight != oldDelegate.minuteHeight ||
            showVerticalLine != oldDelegate.showVerticalLine);
  }
}

class HalfHourLinePainter extends CustomPainter {
  /// Color of half hour line
  final Color lineColor;

  /// Height of half hour line
  final double lineHeight;

  /// Offset of half hour line from left.
  final double offset;

  /// Height occupied by one minute of time stamp.
  final double minuteHeight;

  /// Style of the half hour line
  final LineStyle lineStyle;

  /// Line dash width when using the [LineStyle.dashed] style
  final double dashWidth;

  /// Line dash space width when using the [LineStyle.dashed] style
  final double dashSpaceWidth;
  final MinuteSlotSize? resolutionTime;

  /// Paint half hour lines
  HalfHourLinePainter({
    required this.lineColor,
    required this.lineHeight,
    required this.offset,
    required this.minuteHeight,
    required this.lineStyle,
    this.dashWidth = 4,
    this.dashSpaceWidth = 4,
    this.resolutionTime = MinuteSlotSize.minutes15,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineHeight;

    for (var i = 0; i < Constants.hoursADay; i++) {
      if (resolutionTime == MinuteSlotSize.minutes10) {
        final dy0 = i * minuteHeight * 60 + (minuteHeight * 10);
        final dy1 = i * minuteHeight * 60 + (minuteHeight * 20);
        final dy2 = i * minuteHeight * 60 + (minuteHeight * 30);
        final dy3 = i * minuteHeight * 60 + (minuteHeight * 40);
        final dy4 = i * minuteHeight * 60 + (minuteHeight * 50);
        if (lineStyle == LineStyle.dashed) {
          var startX = offset;
          while (startX < size.width) {
            canvas.drawLine(
                Offset(startX, dy0), Offset(startX + dashWidth, dy0), paint);
            startX += dashWidth + dashSpaceWidth;
          }
        } else {
          canvas
            ..drawLine(Offset(offset, dy0), Offset(size.width, dy0), paint)
            ..drawLine(Offset(offset, dy1), Offset(size.width, dy1), paint)
            ..drawLine(Offset(offset, dy2), Offset(size.width, dy2), paint)
            ..drawLine(Offset(offset, dy3), Offset(size.width, dy3), paint)
            ..drawLine(Offset(offset, dy4), Offset(size.width, dy4), paint);
        }
      } else {
        final dy0 = i * minuteHeight * 60 + (minuteHeight * 15);
        final dy1 = i * minuteHeight * 60 + (minuteHeight * 30);
        final dy2 = i * minuteHeight * 60 + (minuteHeight * 45);
        if (lineStyle == LineStyle.dashed) {
          var startX = offset;
          while (startX < size.width) {
            canvas.drawLine(
                Offset(startX, dy0), Offset(startX + dashWidth, dy0), paint);
            startX += dashWidth + dashSpaceWidth;
          }
        } else {
          canvas
            ..drawLine(Offset(offset, dy0), Offset(size.width, dy0), paint)
            ..drawLine(Offset(offset, dy1), Offset(size.width, dy1), paint)
            ..drawLine(Offset(offset, dy2), Offset(size.width, dy2), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is HourLinePainter &&
        (oldDelegate.lineColor != lineColor ||
            oldDelegate.offset != offset ||
            lineHeight != oldDelegate.lineHeight ||
            minuteHeight != oldDelegate.minuteHeight);
  }
}

/// Paints a single horizontal line at [offset].
class CurrentTimeLinePainter extends CustomPainter {
  /// Color of time indicator.
  final Color color;

  /// Height of time indicator.
  final double height;

  /// offset of time indicator.
  final Offset offset;

  /// Flag to show bullet at left side or not.
  final bool showBullet;

  /// Radius of bullet.
  final double bulletRadius;

  /// Paints a single horizontal line at [offset].
  CurrentTimeLinePainter({
    this.showBullet = true,
    required this.color,
    required this.height,
    required this.offset,
    this.bulletRadius = 5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      Offset(offset.dx, offset.dy),
      Offset(size.width, offset.dy),
      Paint()
        ..color = color
        ..strokeWidth = height,
    );

    if (showBullet)
      canvas.drawCircle(
          Offset(offset.dx, offset.dy), bulletRadius, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is CurrentTimeLinePainter &&
      (color != oldDelegate.color ||
          height != oldDelegate.height ||
          offset != oldDelegate.offset);
}
