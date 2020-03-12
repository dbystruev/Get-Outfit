//
//  launch.dart
//
//  Created by Denis Bystruev on 09/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/screens/login.dart';

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
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'GET OUTFIT',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Futura',
                fontSize: 48 * scale,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20 * scale),
            Text(
              'Выглядеть стильно\nтеперь просто',
              style: TextStyle(
                color: const Color(0xFF54615F),
                fontFamily: 'FuturaMediumC',
                fontSize: 23 * scale,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
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
