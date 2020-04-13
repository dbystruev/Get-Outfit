//
//  lib/widgets/question_widget.dart
//
//  Created by Denis Bystruev on 14/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/models/answer.dart';
import 'package:get_outfit/models/question.dart';
import 'package:get_outfit/widgets/answer_image_widget.dart';
import 'package:get_outfit/widgets/form_widget.dart';
import 'package:get_outfit/widgets/futura_widgets.dart';
import 'package:get_outfit/widgets/radio_widget.dart';

class QuestionWidget extends StatelessWidget {
  static Map<int, TextEditingController> controllers = {};
  final void Function(Answer) onAnswer;
  final int questionIndex;
  final Question question;
  final double scale;

  QuestionWidget(
    this.questionIndex,
    this.question, {
    @required this.onAnswer,
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
          child: FormWidget.quiz(
            hintText: question.title,
            onChanged: (String newString) => onAnswer(
              Answer.text(newString),
            ),
          ),
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
        final int selectedIndex = question.givenAnswer.indexes.first ?? 0;
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
                  onChanged: (int value) => onAnswer(
                    Answer.single(value),
                  ),
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
        final TextEditingController controller =
            controllers[question.id] ?? TextEditingController();
        controllers[question.id] = controller;
        final String newText = question.givenAnswer.text ?? '';
        if (controller.text != newText) controller.text = newText;
        return FormWidget.quiz(
          controller: controller,
          fontSize: 14 * scale,
          onChanged: (String newText) => onAnswer(
            Answer.text(newText),
          ),
        );
    }
  }

  Widget buildImages() {
    final List<Widget> images = question.answers
        .asMap()
        .map(
          (index, url) => MapEntry(
            index,
            Padding(
              child: AnswerImageWidget(
                url,
                index: index,
                onSelected: (index) => onAnswer(
                  Answer.invertIndex(index,
                      oldIndexes: question.givenAnswer?.indexes),
                ),
                scale: scale,
                selected:
                    question.givenAnswer?.indexes?.contains(index) == true,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 5 * scale,
                vertical: 15 * scale,
              ),
            ),
          ),
        )
        .values
        .toList();
    return SizedBox(
      child: ListView(
        children: images,
        scrollDirection: Axis.horizontal,
      ),
      height: 180 * scale,
    );
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
          question.isVisual ? buildImages() : buildAnswers(),
        ].where((element) => element != null).toList(),
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      padding: EdgeInsets.only(bottom: 15 * scale, top: 10 * scale),
    );
  }
}
