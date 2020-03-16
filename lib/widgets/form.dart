//
//  lib/widgets/form.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration decoration;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final TextInputType keyboardType;
  final String labelText;
  final bool obscureText;

  FormWidget({
    this.controller,
    this.decoration,
    this.fontFamily,
    this.fontSize,
    this.fontWeight,
    this.keyboardType,
    this.labelText,
    this.obscureText = false,
  });

  factory FormWidget.quiz({
    TextEditingController controller,
    double fontSize,
    String labelText,
  }) =>
      FormWidget(
        controller: controller,
        fontFamily: 'FuturaBook',
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        labelText: labelText,
      );

  factory FormWidget.login({
    TextEditingController controller,
    double fontSize,
    TextInputType keyboardType,
    String labelText,
    bool obscureText,
  }) =>
      FormWidget(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide.none,
          ),
          fillColor: Color.fromARGB(26, 84, 97, 95),
          filled: true,
          labelText: labelText,
        ),
        fontFamily: 'FuturaMedium',
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        keyboardType: keyboardType,
        labelText: labelText,
        obscureText: obscureText ?? false,
      );

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        decoration: decoration,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      );
}
