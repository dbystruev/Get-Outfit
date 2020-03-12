//
//  scale.dart
//
//  Created by Denis Bystruev on 11/03/2020.
//

import 'dart:math';
import 'package:flutter/material.dart';

mixin Scale {
  final Color background = const Color(0xFFFFFFFF);
  static const double defaultHeight = 375;
  static const double defaultWidth = 375;

  double getScale(
    BuildContext context, {
    double height = defaultHeight,
    double width = defaultWidth,
  }) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalScale = screenWidth / width;
    final double verticalScale = screenHeight / height;
    final double scale = min(horizontalScale, verticalScale);
    print('DEBUG in lib/design/scale.dart line 15: scale = $scale');
    return scale;
  }
}
