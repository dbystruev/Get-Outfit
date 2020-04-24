//
//  lib/screens/thank_you_screen.dart
//
//  Created by Denis Bystruev on 07/04/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/widgets/button_widget.dart';

class ThankYouScreen extends StatelessWidget with Scale {
  @override
  Widget build(BuildContext context) {
    final double scale = getScale(context);
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: ButtonWidget(
            'Спасибо! Наш стилист свяжется\nс вами в течение 15 минут.',
            buttonColor: Color(0xFF62C584),
            fontSize: 18,
            height: 80,
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            scale: scale,
            width: 315,
          ),
        ),
        onTap: () {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }
}
