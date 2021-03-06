//
//  lib/widgets/footer_button_widget.dart
//
//  Created by Denis Bystruev on 13/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/widgets/button_widget.dart';

class FooterButtonWidget extends StatelessWidget {
  final Color buttonColor;
  final Function() onPressed;
  final double scale;
  final String text;

  FooterButtonWidget(
    this.text, {
    this.buttonColor,
    this.onPressed,
    this.scale = 1,
  });

  @override
  Widget build(BuildContext context) => text == null
      ? SizedBox(height: 40 * scale, width: 90 * scale)
      : ButtonWidget(
          text,
          buttonColor: buttonColor ?? Theme.of(context).primaryColor,
          fontSize: 14,
          height: 40,
          onPressed: onPressed,
          scale: scale,
          width: 90,
        );
}
