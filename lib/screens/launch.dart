import 'package:flutter/material.dart';

class LaunchScreen extends StatelessWidget {
  final Color background = const Color(0xFFFFFFFF);
  final int height = 812;
  final int width = 375;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                'GET OUTFIT',
                style: TextStyle(
                  fontFamily: 'Futura',
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Выглядеть стильно\nтеперь просто',
                style: TextStyle(
                  color: const Color(0xFF54615F),
                  fontFamily: 'FuturaMediumC',
                  fontSize: 23,
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
