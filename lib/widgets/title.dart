//
//  title.dart
//
//  Created by Denis Bystruev on 11/03/2020.
//

import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final double fontSize;
  final String text;

  TitleWidget(this.text, {this.fontSize});

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          color: const Color(0xFF54615F),
          fontFamily: 'FuturaMediumC',
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      );
}
