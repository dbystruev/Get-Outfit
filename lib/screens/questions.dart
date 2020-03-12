//
//  questions.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/widgets/button.dart';
import 'package:get_outfit/widgets/title.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> with Scale {
  @override
  Widget build(BuildContext context) {
    print(
        'DEBUG in lib/screens/questions.dart line 18: _LoginScreenState.build');
    final double scale = getScale(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            child: ListView(
              children: <Widget>[
                TitleWidget(
                  'Здравствуйте!\nРасскажите нам о себе,\nэто займет не более 8 минут.',
                  fontSize: 20 * scale,
                ),
                ButtonWidget(
                  'Далее',
                  onPressed: () {
                    print(
                        'DEBUG in lib/screens/questions.dart line 37: next pressed');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            padding: EdgeInsets.all(30 * scale),
          ),
        ),
      ),
    );
  }
}
