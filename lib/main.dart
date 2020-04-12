//
//  main.dart
//
//  Created by Denis Bystruev on 09/03/2020.
//

import 'package:flutter/material.dart';
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
          canvasColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(
              color: const Color.fromARGB(102, 0, 0, 0),
            ),
          ),
        ),
        title: 'Get Outfit',
      );
}
