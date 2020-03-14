//
//  futura.dart
//
//  Created by Denis Bystruev on 13/03/2020.
//

import 'package:flutter/material.dart';

class FuturaBookText extends StatelessWidget {
  final Color color;
  final double fontSize;
  final String text;
  final FontWeight fontWeight;

  FuturaBookText.bold(
    this.text, {
    this.color = const Color(0xFF54615F),
    this.fontSize,
    this.fontWeight = FontWeight.bold,
  });

  FuturaBookText.normal(
    this.text, {
    this.color = const Color(0xFF54615F),
    this.fontSize,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) => FuturaText(
        text,
        color: color,
        fontFamily: 'FuturaBookC',
        fontSize: fontSize,
        fontWeight: fontWeight,
      );
}

class FuturaDemiText extends StatelessWidget {
  final Color color;
  final double fontSize;
  final String text;
  final FontWeight fontWeight;

  FuturaDemiText.w500(
    this.text, {
    this.color = const Color(0xFF54615F),
    this.fontSize,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) => FuturaText.bold(
        text,
        color: color,
        fontFamily: 'FuturaDemiC',
        fontSize: fontSize,
        fontWeight: fontWeight,
      );
}

class FuturaMediumText extends StatelessWidget {
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final String text;

  FuturaMediumText.w500(
    this.text, {
    this.color = const Color(0xFF54615F),
    this.fontSize,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) => FuturaText(
        text,
        color: color,
        fontFamily: 'FuturaMediumC',
        fontSize: fontSize,
        fontWeight: fontWeight,
      );
}

class FuturaText extends StatelessWidget {
  final Color color;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final String text;

  FuturaText(
    this.text, {
    this.color,
    this.fontFamily = 'Futura',
    this.fontSize,
    this.fontWeight,
  });

  FuturaText.bold(
    this.text, {
    this.color,
    this.fontFamily = 'Futura',
    this.fontSize,
    this.fontWeight = FontWeight.bold,
  });

  FuturaText.normal(
    this.text, {
    this.color,
    this.fontFamily = 'Futura',
    this.fontSize,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      );
}
