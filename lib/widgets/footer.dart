//
//  lib/widgets/footer.dart
//
//  Created by Denis Bystruev on 13/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/widgets/footer_button.dart';
import 'package:get_outfit/widgets/futura.dart';

class FooterWidget extends StatelessWidget {
  final String leftText;
  final String middleText;
  final Function() onLeftPressed;
  final Function() onRightPressed;
  final String rightText;
  final double scale;

  FooterWidget({
    this.leftText,
    this.middleText,
    this.onLeftPressed,
    this.onRightPressed,
    this.rightText,
    this.scale = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(30 * scale, 20 * scale, 30 * scale, 10 * scale),
      child: Row(
        children: <Widget>[
          FooterButtonWidget(leftText, onPressed: onLeftPressed, scale: scale),
          FuturaBookText.normal(middleText, fontSize: 14 * scale),
          FooterButtonWidget(
            rightText,
            buttonColor: Color.fromARGB(179, 84, 97, 95),
            onPressed: onRightPressed,
            scale: scale,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
