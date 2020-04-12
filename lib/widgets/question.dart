//
//  lib/widgets/question.dart
//
//  Created by Denis Bystruev on 14/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/models/question.dart';
import 'package:get_outfit/widgets/form.dart';
import 'package:get_outfit/widgets/futura.dart';
import 'package:get_outfit/widgets/radio.dart';

class QuestionWidget extends StatelessWidget {
  final int questionIndex;
  final Question question;
  final void Function(void Function()) setState;
  final double scale;

  QuestionWidget(
    this.questionIndex,
    this.question, {
    @required this.setState,
    @required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final double topInset = questionIndex == 0 ? 0 : 50 * scale;
    switch (question.type) {
      case QuestionType.header:
        return Padding(
          child: FuturaDemiText.w600(question.title, fontSize: 20 * scale),
          padding: EdgeInsets.only(bottom: 30 * scale, top: topInset),
        );
      case QuestionType.inlineText:
        return Padding(
          child: FormWidget.quiz(hintText: question.title),
          padding: EdgeInsets.symmetric(vertical: 11 * scale),
        );
      case QuestionType.multiChoice:
      case QuestionType.range:
      case QuestionType.singleChoice:
      case QuestionType.text:
      default:
        return buildQuestion();
    }
  }

  Widget buildAnswers() {
    switch (question.type) {
      case QuestionType.singleChoice:
        int selectedIndex = question.defaultAnswer;
        final int textLength = question.answers
            .map((text) => text.length)
            .reduce((total, current) => total + current);
        final bool isVertical = 5 < question.answers.length || 25 < textLength;
        final List<Widget> radioButtons = question.answers
            .asMap()
            .map(
              (index, answer) => MapEntry(
                index,
                RadioWidget(
                  groupValue: selectedIndex,
                  label: FuturaBookText.normal(
                    answer,
                    fontSize: 14 * scale,
                    textAlign: TextAlign.start,
                  ),
                  labelFlex: isVertical ? 10 : 2,
                  onChanged: (int value) => setState(() {
                    selectedIndex = value;
                    print(
                        'DEBUG in lib/widgets/question.dart line 67: index = $index, selectedIndex = $selectedIndex');
                  }),
                  scale: scale,
                  value: index,
                ),
              ),
            )
            .values
            .map(
              (widget) =>
                  isVertical ? widget : Flexible(child: widget, flex: 1),
            )
            .toList();
        return Flex(
            children: radioButtons,
            direction: isVertical ? Axis.vertical : Axis.horizontal);
      case QuestionType.text:
      default:
        return FormWidget.quiz(fontSize: 14 * scale);
    }
  }

  Widget buildQuestion() {
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
          buildAnswers(),
        ].where((element) => element != null).toList(),
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      padding: EdgeInsets.only(bottom: 15 * scale, top: 10 * scale),
    );
  }
}
