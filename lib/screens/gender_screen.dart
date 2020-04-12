//
//  lib/screens/gender_screen.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/models/gender.dart';
import 'package:get_outfit/screens/quiz_screen.dart';
import 'package:get_outfit/widgets/button_widget.dart';
import 'package:get_outfit/widgets/futura_widgets.dart';

class GenderScreen extends StatelessWidget with Scale {
  @override
  Widget build(BuildContext context) {
    final double scale = getScale(context);
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Column(
            children: <Widget>[
              FuturaText.bold('GET OUTFIT', fontSize: 28 * scale),
              SizedBox(height: (isHorizontal(context) ? 15 : 205) * scale),
              FuturaDemiText.w500(
                'Для кого подбираем образ?',
                fontSize: 20 * scale,
              ),
              SizedBox(height: (isHorizontal(context) ? 15 : 41) * scale),
              ButtonWidget(
                'для мужчины',
                buttonColor: Color(0xFF54615F),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(Gender.male),
                    ),
                  );
                },
                scale: scale,
              ),
              SizedBox(height: 15 * scale),
              ButtonWidget(
                'для женщины',
                borderColor: Color(0xFF54615F),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(Gender.female),
                    ),
                  );
                },
                scale: scale,
                textColor: Color(0xFF54615F),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          if (0 < details.delta.dx) Navigator.pop(context);
        },
      ),
    );
  }
}
