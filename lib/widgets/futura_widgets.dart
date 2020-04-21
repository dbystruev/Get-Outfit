//
//  lib/widgets/futura_widgets.dart
//
//  Created by Denis Bystruev on 13/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/globals.dart' as globals;

class FuturaBookText extends StatelessWidget {
  final Color color;
  final double fontSize;
  final String text;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  FuturaBookText(
    this.text, {
    this.color = globals.accentColor,
    this.fontSize,
    this.fontWeight,
    this.textAlign = TextAlign.center,
  });

  factory FuturaBookText.bold(String text,
          {Color color, double fontSize, TextAlign textAlign}) =>
      FuturaBookText(
        text,
        color: color ?? globals.accentColor,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        textAlign: textAlign ?? TextAlign.center,
      );

  factory FuturaBookText.normal(String text,
          {Color color, double fontSize, TextAlign textAlign}) =>
      FuturaBookText(
        text,
        color: color ?? globals.accentColor,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        textAlign: textAlign ?? TextAlign.center,
      );

  @override
  Widget build(BuildContext context) => FuturaText(
        text,
        color: color,
        fontFamily: 'FuturaBook',
        fontSize: fontSize,
        fontWeight: fontWeight,
        textAlign: textAlign,
      );
}

class FuturaDemiText extends StatelessWidget {
  final Color color;
  final double fontSize;
  final String text;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  FuturaDemiText(
    this.text, {
    this.color = globals.accentColor,
    this.fontSize,
    this.fontWeight,
    this.textAlign = TextAlign.center,
  });

  factory FuturaDemiText.w500(
    String text, {
    Color color,
    double fontSize,
    TextAlign textAlign,
  }) =>
      FuturaDemiText(
        text,
        color: color ?? globals.accentColor,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        textAlign: textAlign ?? TextAlign.center,
      );

  factory FuturaDemiText.w600(
    String text, {
    Color color,
    double fontSize,
    TextAlign textAlign,
  }) =>
      FuturaDemiText(
        text,
        color: color ?? globals.accentColor,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        textAlign: textAlign ?? TextAlign.center,
      );

  @override
  Widget build(BuildContext context) => FuturaText(
        text,
        color: color,
        fontFamily: 'FuturaDemi',
        fontSize: fontSize,
        fontWeight: fontWeight,
        textAlign: textAlign,
      );
}

class FuturaMediumText extends StatelessWidget {
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final String text;
  final TextAlign textAlign;

  FuturaMediumText(
    this.text, {
    this.color = globals.accentColor,
    this.fontSize,
    this.fontWeight,
    this.textAlign = TextAlign.center,
  });

  factory FuturaMediumText.w500(
    String text, {
    Color color,
    double fontSize,
    TextAlign textAlign,
  }) =>
      FuturaMediumText(
        text,
        color: color ?? globals.accentColor,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        textAlign: textAlign ?? TextAlign.center,
      );

  @override
  Widget build(BuildContext context) => FuturaText(
        text,
        color: color,
        fontFamily: 'FuturaMedium',
        fontSize: fontSize,
        fontWeight: fontWeight,
        textAlign: textAlign,
      );
}

class FuturaText extends StatelessWidget {
  final Color color;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final String text;
  final TextAlign textAlign;

  FuturaText(
    this.text, {
    this.color,
    this.fontFamily = 'Futura',
    this.fontSize,
    this.fontWeight,
    this.textAlign = TextAlign.center,
  });

  factory FuturaText.bold(String text, {Color color, double fontSize}) =>
      FuturaText(text,
          color: color, fontSize: fontSize, fontWeight: FontWeight.bold);

  factory FuturaText.normal(String text, {Color color, double fontSize}) =>
      FuturaText(text,
          color: color, fontSize: fontSize, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        textAlign: textAlign,
      );
}
