//
//  gender.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/widgets/button.dart';
import 'package:get_outfit/widgets/logo.dart';
import 'package:get_outfit/widgets/title.dart';

class GenderScreen extends StatelessWidget with Scale {
  final GlobalKey<State<StatefulWidget>> sizingKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final double scale = getScale(context, height: 420);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final double height =
          (sizingKey.currentContext?.findRenderObject() as RenderBox)
              .size
              .height;
      print('DEBUG in lib/screens/gender.dart line 24: height = $height');
    });
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            LogoWidget(fontSize: 32 * scale),
            SizedBox(
                height:
                    (isHorizontal(context) && scale < 1 ? 15 : 205) * scale),
            TitleWidget('Для кого подбираем образ?', fontSize: 23 * scale),
            SizedBox(
                height: (isHorizontal(context) && scale < 1 ? 15 : 41) * scale),
            ButtonWidget(
              'для мужчины',
              buttonColor: Color(0xFF54615F),
              onPressed: () {
                print('DEBUG in lib/screens/gender.dart line 41: men selected');
                Navigator.pop(context);
              },
              scale: scale,
              textColor: Colors.white,
            ),
            SizedBox(height: 15 * scale),
            ButtonWidget(
              'для женщины',
              borderColor: Color(0xFF54615F),
              onPressed: () {
                print(
                    'DEBUG in lib/screens/gender.dart line 53: women selected');
                Navigator.pop(context);
              },
              scale: scale,
              textColor: Color(0xFF54615F),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          key: sizingKey,
        ),
      ),
    );
  }
}
