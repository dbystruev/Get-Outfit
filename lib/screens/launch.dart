import 'dart:math';
import 'package:flutter/material.dart';

class LaunchScreen extends StatelessWidget {
  final Color background = const Color(0xFFFFFFFF);
  final double designHeight = 375;
  final double designWidth = 375;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalScale = screenWidth / designWidth;
    final double verticalScale = screenHeight / designHeight;
    final double scale = min(horizontalScale, verticalScale);
    print('DEBUG in lib/screens/launch.dart line 11: scale = $scale');
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
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
