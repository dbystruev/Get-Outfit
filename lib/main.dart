//
//  main.dart
//
//  Created by Denis Bystruev on 09/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/globals.dart' as globals;
import 'package:get_outfit/screens/launch_screen.dart';

void main() => runApp(
      Main(),
    );

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LaunchScreen(),
        theme: ThemeData(
          accentColor: globals.accentColor,
          canvasColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(
              color: globals.textColor,
            ),
          ),
          primaryColor: globals.primaryColor,
        ),
        title: 'Get Outfit',
      );
}
