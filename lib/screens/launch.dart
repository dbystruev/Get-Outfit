//
//  launch.dart
//
//  Created by Denis Bystruev on 09/03/2020.
//

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/screens/login.dart';
import 'package:get_outfit/widgets/logo.dart';
import 'package:get_outfit/widgets/title.dart';

class LaunchScreen extends StatelessWidget with Scale {
  static bool built = false;
  @override
  Widget build(BuildContext context) {
    if (!built) {
      built = true;
      navigateWithDelay(context, 3);
    }
    print('DEBUG in lib/screens/launch.dart line 22: _LoginScreenState.build');
    final double scale = getScale(context);
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Column(
            children: <Widget>[
              LogoWidget(fontSize: 48 * scale),
              SizedBox(height: 20 * scale),
              TitleWidget('Выглядеть стильно\nтеперь просто',
                  fontSize: 23 * scale),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        onTap: () {
          navigateWithDelay(context, 0);
        },
      ),
    );
  }

  void navigateWithDelay(BuildContext context, int seconds) async {
    final duration = Duration(seconds: seconds);
    await Future.delayed(duration);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}
