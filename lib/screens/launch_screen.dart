//
//  lib/screens/launch_screen.dart
//
//  Created by Denis Bystruev on 09/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/screens/login_screen.dart';
import 'package:get_outfit/widgets/futura_widgets.dart';

class LaunchScreen extends StatelessWidget with Scale {
  static bool built = false;
  @override
  Widget build(BuildContext context) {
    if (!built) {
      built = true;
      navigateWithDelay(context, 3);
    }
    final double scale = getScale(context);
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Column(
            children: <Widget>[
              FuturaText.bold('GET OUTFIT', fontSize: 42 * scale),
              SizedBox(height: 20 * scale),
              FuturaMediumText.w500(
                'Выглядеть стильно\nтеперь просто',
                fontSize: 22 * scale,
              ),
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
