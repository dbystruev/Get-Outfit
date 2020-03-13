//
//  footer_button.dart
//
//  Created by Denis Bystruev on 13/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/widgets/button.dart';

class FooterButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final double scale;
  final String text;

  FooterButtonWidget(this.text, {this.onPressed, this.scale = 1});

  @override
  Widget build(BuildContext context) => ButtonWidget(
        text,
        buttonColor: Color.fromARGB(179, 84, 97, 95),
        fontSize: 14,
        height: 40,
        onPressed: onPressed,
        scale: scale,
        width: 90,
      );
}
