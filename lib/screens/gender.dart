//
//  lib/screens/gender.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/screens/questions.dart';
import 'package:get_outfit/widgets/button.dart';
import 'package:get_outfit/widgets/futura.dart';

class GenderScreen extends StatelessWidget with Scale {
  @override
  Widget build(BuildContext context) {
    final double scale = getScale(context, height: 460);
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            FuturaText.bold('GET OUTFIT', fontSize: 28 * scale),
            SizedBox(
                height:
                    (isHorizontal(context) && scale < 1 ? 15 : 205) * scale),
            FuturaDemiText.w500(
              'Для кого подбираем образ?',
              fontSize: 20 * scale,
            ),
            SizedBox(
                height: (isHorizontal(context) && scale < 1 ? 15 : 41) * scale),
            ButtonWidget(
              'для мужчины',
              buttonColor: Color(0xFF54615F),
              onPressed: () {
                print('DEBUG in lib/screens/gender.dart line 35: men selected');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionScreen(),
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
                print(
                    'DEBUG in lib/screens/gender.dart line 51: women selected');
                Navigator.pop(context);
              },
              scale: scale,
              textColor: Color(0xFF54615F),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
