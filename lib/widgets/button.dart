//
//  button.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color borderColor;
  final double borderWidth;
  final Color buttonColor;
  final double fontSize;
  final double imageHeight;
  final String imageName;
  final double imageWidth;
  final void Function() onPressed;
  final double scale;
  final String text;
  final Color textColor;

  ButtonWidget(
    this.text, {
    this.borderColor,
    this.borderWidth = 2,
    this.buttonColor,
    this.fontSize = 16,
    this.imageHeight = 18,
    this.imageName,
    this.imageWidth = 18,
    this.onPressed,
    this.scale = 1,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final Text textWidget = Text(
      text,
      style: TextStyle(
        fontFamily: 'FuturaMediumC',
        fontSize: fontSize * scale,
        fontWeight: FontWeight.w500,
      ),
    );
    return ButtonTheme(
      child: Padding(
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
                    textWidget
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
        padding: EdgeInsets.symmetric(horizontal: 54 * scale),
      ),
      height: 50 * scale,
      minWidth: 228 * scale,
    );
  }
}
