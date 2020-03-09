import 'package:flutter/material.dart';
import 'package:get_outfit/screens/launch.dart';

void main() => runApp(
      Main(),
    );

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LaunchScreen(),
        title: 'Get Outfit',
      );
}
