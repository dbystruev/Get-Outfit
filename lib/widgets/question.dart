//
//  lib/widgets/question.dart
//
//  Created by Denis Bystruev on 14/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/models/question.dart';
import 'package:get_outfit/widgets/form.dart';
import 'package:get_outfit/widgets/futura.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final double scale;

  QuestionWidget(this.question, {this.scale});

  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case QuestionType.header:
        return Padding(
          child: FuturaDemiText.w600(question.title, fontSize: 20 * scale),
          padding: EdgeInsets.only(bottom: 30 * scale, top: 50 * scale),
        );
      case QuestionType.multiChoice:
      case QuestionType.range:
      case QuestionType.singleChoice:
      case QuestionType.text:
        return Padding(
          child: Column(
            children: <Widget>[
              FuturaMediumText.w500(
                question.title,
                fontSize: 16 * scale,
                textAlign: TextAlign.start,
              ),
              question.subtitle == null
                  ? null
                  : FuturaBookText.normal(
                      question.subtitle,
                      fontSize: 10 * scale,
                      textAlign: TextAlign.start,
                    ),
              FormWidget.quiz(fontSize: 14 * scale),
            ].where((element) => element != null).toList(),
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          padding: EdgeInsets.only(bottom: 15 * scale, top: 10 * scale),
        );
    }
    print('ERROR in lib/widgets/question.dart line 44: question = $question');
    return FuturaText.bold('Unknown question type: ${question.type}',
        color: Colors.red, fontSize: 20 * scale);
  }
}
