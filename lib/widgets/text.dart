//
//  text.dart
//
//  Created by Denis Bystruev on 13/03/2020.
//

import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final Color color;
  final double fontSize;
  final String text;

  TextWidget(this.text, {this.color = const Color(0xFF54615F), this.fontSize});

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          color: color,
          fontFamily: 'FuturaBookC',
          fontSize: fontSize,
        ),
        textAlign: TextAlign.center,
      );
}
