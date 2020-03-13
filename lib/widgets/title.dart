//
//  title.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final Color color;
  final double fontSize;
  final String text;

  TitleWidget(this.text, {this.color = const Color(0xFF54615F), this.fontSize});

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          color: color,
          fontFamily: 'FuturaMediumC',
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      );
}
