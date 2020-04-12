//
//  lib/widgets/button_widget.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/widgets/futura_widgets.dart';

class ButtonWidget extends StatelessWidget {
  final Color borderColor;
  final double borderWidth;
  final Color buttonColor;
  final double fontSize;
  final double imageHeight;
  final String imageName;
  final double imageWidth;
  final double height;
  final MainAxisAlignment mainAxisAlignment;
  final void Function() onPressed;
  final double scale;
  final String text;
  final Color textColor;
  final double width;

  ButtonWidget(
    this.text, {
    this.borderColor,
    this.borderWidth = 2,
    this.buttonColor,
    this.fontSize = 16,
    this.height = 50,
    this.imageHeight = 18,
    this.imageName,
    this.imageWidth = 18,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.onPressed,
    this.scale = 1,
    this.textColor = Colors.white,
    this.width = 228,
  });

  @override
  Widget build(BuildContext context) {
    final FuturaMediumText textWidget = FuturaMediumText.w500(
      text,
      color: textColor,
      fontSize: fontSize * scale,
    );
    return Row(
      children: <Widget>[
        SizedBox(
          child: FlatButton(
            color: buttonColor,
            child: imageName == null
                ? textWidget
                : Row(
                    children: <Widget>[
                      Image.asset(
                        imageName,
                        height: imageHeight * scale,
                        width: imageWidth * scale,
                      ),
                      SizedBox(width: 8 * scale),
                      textWidget,
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
            onPressed: onPressed,
            shape: borderColor == null
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9 * scale),
                  )
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9 * scale),
                    side: BorderSide(
                      color: borderColor,
                      width: borderWidth * scale,
                    ),
                  ),
            textColor: textColor,
          ),
          height: height * scale,
          width: width * scale,
        ),
      ],
      mainAxisAlignment: mainAxisAlignment,
    );
  }
}
