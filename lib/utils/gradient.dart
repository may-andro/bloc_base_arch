import 'package:flutter/material.dart';

class AppGradient {

  const AppGradient();

  static List<Color> getColors() {
    DateTime now = DateTime.now();
    int timeAsMins = now.hour * 60 + now.minute;
    var lerpValue = (timeAsMins <= 720) ? timeAsMins / 720 : (2 - timeAsMins / 720);
    var topSkyColor = Color.lerp(
        Colors.grey.shade700, Colors.blueGrey.shade700, lerpValue);
    var bottomSkyColor = Color.lerp(
        Colors.grey.shade100, Colors.blueGrey.shade100, lerpValue)
        .withOpacity(0.8);
    return [topSkyColor, bottomSkyColor];
  }
}