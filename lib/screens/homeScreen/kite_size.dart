import 'package:flutter/material.dart';

class KiteSizeText extends StatelessWidget {
  final int userWeight;
  final double windSpeedKmh;

  const KiteSizeText({
    super.key,
    required this.userWeight,
    required this.windSpeedKmh,
  });

  static final Map<int, List<int>> _kiteSizes = {
    50: [11, 9, 8, 7, 6, 6, 5, 5, 4, 4, 4],
    60: [13, 11, 9, 8, 7, 7, 6, 6, 5, 5, 4],
    70: [15, 13, 11, 10, 9, 8, 7, 6, 6, 5, 5],
    80: [18, 15, 13, 11, 10, 9, 8, 7, 6, 6, 6],
    90: [20, 17, 14, 12, 11, 10, 9, 8, 8, 7, 7],
    100: [22, 18, 16, 14, 12, 11, 10, 9, 8, 8, 7],
    110: [24, 20, 17, 15, 13, 12, 11, 10, 9, 9, 8],
    120: [26, 22, 19, 17, 15, 13, 12, 11, 10, 9, 9],
  };

  static final List<int> _windSpeedsKnots = [
    10,
    12,
    14,
    16,
    18,
    20,
    22,
    24,
    26,
    28,
    30
  ];

  String _getKiteSize() {
    int closestWeight = _findClosestWeight(userWeight);

    double windSpeedKnots = windSpeedKmh / 1.852;
    int closestWindSpeed = _findClosestWindSpeed(windSpeedKnots);

    int windIndex = _windSpeedsKnots.indexOf(closestWindSpeed);

    if (windIndex == -1) {
      return "No data for this wind speed";
    }

    return "${_kiteSizes[closestWeight]![windIndex]} meters kite";
  }

  int _findClosestWeight(int weight) {
    int closest = _kiteSizes.keys.first;
    int minDiff = (weight - closest).abs();

    for (var w in _kiteSizes.keys) {
      int diff = (weight - w).abs();
      if (diff < minDiff) {
        closest = w;
        minDiff = diff;
      }
    }

    return closest;
  }

  int _findClosestWindSpeed(double windSpeedKnots) {
    int closest = _windSpeedsKnots.first;
    double minDiff = (windSpeedKnots - closest).abs();

    for (var speed in _windSpeedsKnots) {
      double diff = (windSpeedKnots - speed).abs();
      if (diff < minDiff) {
        closest = speed;
        minDiff = diff;
      }
    }

    return closest;
  }

  @override
  Widget build(BuildContext context) {
    String kiteSizeText = _getKiteSize();

    return Column(
      children: [
        Text(
          "Suggested Kite Length:",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Text(
          kiteSizeText,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
