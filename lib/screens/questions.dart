//
//  lib/screens/questions.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/widgets/footer.dart';
import 'package:get_outfit/widgets/futura.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> with Scale {
  @override
  Widget build(BuildContext context) {
    print(
        'DEBUG in lib/screens/questions.dart line 21: _LoginScreenState.build');
    final double scale = getScale(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: <Widget>[
              FuturaDemiText.w500(
                'Здравствуйте!\nРасскажите нам о себе,\nэто займет не более 8 минут.',
                fontSize: 20 * scale,
              ),
              SizedBox(height: 40 * scale),
              FooterWidget(
                leftText: '',
                middleText: '1 из 5',
                onRightPressed: () {
                  print(
                      'DEBUG in lib/screens/questions.dart line 38: next pressed');
                  Navigator.pop(context);
                },
                rightText: 'Далее',
                scale: scale,
              ),
            ],
            padding: EdgeInsets.all(30 * scale),
          ),
        ),
      ),
    );
  }
}
