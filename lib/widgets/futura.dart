//
//  lib/widgets/futura.dart
//
//  Created by Denis Bystruev on 13/03/2020.
//

import 'package:flutter/material.dart';

class FuturaBookText extends StatelessWidget {
  final Color color;
  final double fontSize;
  final String text;
  final FontWeight fontWeight;

  FuturaBookText(this.text,
      {this.color = const Color(0xFF54615F), this.fontSize, this.fontWeight});

  factory FuturaBookText.bold(String text, {Color color, double fontSize}) =>
      FuturaBookText(text,
          color: color, fontSize: fontSize, fontWeight: FontWeight.bold);

  factory FuturaBookText.normal(String text, {Color color, double fontSize}) =>
      FuturaBookText(text,
          color: color, fontSize: fontSize, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) => FuturaText(
        text,
        color: color,
        fontFamily: 'FuturaBook',
        fontSize: fontSize,
        fontWeight: fontWeight,
      );
}

class FuturaDemiText extends StatelessWidget {
  final Color color;
  final double fontSize;
  final String text;
  final FontWeight fontWeight;

  FuturaDemiText(this.text,
      {this.color = const Color(0xFF54615F), this.fontSize, this.fontWeight});

  factory FuturaDemiText.w500(String text, {Color color, double fontSize}) =>
      FuturaDemiText(text,
          color: color, fontSize: fontSize, fontWeight: FontWeight.w500);

  factory FuturaDemiText.w600(String text, {Color color, double fontSize}) =>
      FuturaDemiText(text,
          color: color, fontSize: fontSize, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) => FuturaText(
        text,
        color: color,
        fontFamily: 'FuturaDemi',
        fontSize: fontSize,
        fontWeight: fontWeight,
      );
}

class FuturaMediumText extends StatelessWidget {
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final String text;

  FuturaMediumText(this.text,
      {this.color = const Color(0xFF54615F), this.fontSize, this.fontWeight});

  factory FuturaMediumText.w500(String text, {Color color, double fontSize}) =>
      FuturaMediumText(text,
          color: color, fontSize: fontSize, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) => FuturaText(
        text,
        color: color,
        fontFamily: 'FuturaMedium',
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

  FuturaText(this.text,
      {this.color, this.fontFamily = 'Futura', this.fontSize, this.fontWeight});

  factory FuturaText.bold(String text, {Color color, double fontSize}) =>
      FuturaText(text,
          color: color, fontSize: fontSize, fontWeight: FontWeight.bold);

  factory FuturaText.normal(String text, {Color color, double fontSize}) =>
      FuturaText(text,
          color: color, fontSize: fontSize, fontWeight: FontWeight.normal);

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
