//
//  logo.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double fontSize;
  final String text;

  LogoWidget({this.fontSize, this.text = 'GET OUTFIT'});

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Futura',
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      );
}
