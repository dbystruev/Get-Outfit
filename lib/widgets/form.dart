//
//  lib/widgets/form.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final TextEditingController controller;
  final double fontSize;
  final TextInputType keyboardType;
  final String labelText;
  final bool obscureText;

  FormWidget({
    this.controller,
    this.fontSize,
    this.keyboardType,
    this.labelText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
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
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(
          fontFamily: 'FuturaMediumC',
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      );
}
