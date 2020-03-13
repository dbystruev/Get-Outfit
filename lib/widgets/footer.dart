//
//  footer.dart
//
//  Created by Denis Bystruev on 13/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/widgets/footer_button.dart';
import 'package:get_outfit/widgets/text.dart';

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
    return Row(
      children: <Widget>[
        FooterButtonWidget(leftText, onPressed: onLeftPressed, scale: scale),
        TextWidget(middleText, fontSize: 14 * scale),
        FooterButtonWidget(
          rightText,
          onPressed: onRightPressed,
          scale: scale,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
