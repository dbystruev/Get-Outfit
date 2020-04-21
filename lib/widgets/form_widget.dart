//
//  lib/widgets/form_widget.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/globals.dart' as globals;

class FormWidget extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration decoration;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final String hintText;
  final TextInputType keyboardType;
  final String labelText;
  final bool obscureText;
  final Function(String) onChanged;

  FormWidget({
    this.controller,
    this.decoration,
    this.fontFamily,
    this.fontSize,
    this.fontWeight,
    this.hintText,
    this.keyboardType,
    this.labelText,
    this.obscureText = false,
    this.onChanged,
  });

  factory FormWidget.quiz({
    TextEditingController controller,
    double fontSize,
    String hintText,
    String initialValue,
    String labelText,
    Function(String) onChanged,
  }) =>
      FormWidget(
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          hintStyle: TextStyle(
            color: Color.fromARGB(179, 84, 97, 95),
          ),
          hintText: hintText,
        ),
        fontFamily: 'FuturaBook',
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        hintText: hintText,
        labelText: labelText,
        onChanged: onChanged,
      );

  factory FormWidget.login({
    TextEditingController controller,
    double fontSize,
    TextInputType keyboardType,
    String initialValue,
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
        cursorColor: Theme.of(context).primaryColor,
        decoration: decoration,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      );
}
