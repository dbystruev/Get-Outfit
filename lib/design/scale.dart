//
//  lib/design/scale.dart
//
//  Created by Denis Bystruev on 11/03/2020.
//

import 'dart:math';
import 'package:flutter/material.dart';

mixin Scale {
  static const double defaultHeight = 375;
  static const double defaultWidth = 375;

  bool isHorizontal(BuildContext context) =>
      MediaQuery.of(context).size.height < MediaQuery.of(context).size.width;

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
    print('DEBUG in lib/design/scale.dart line 27: scale = $scale');
    return scale;
  }
}
