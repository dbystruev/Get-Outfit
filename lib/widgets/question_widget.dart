//
//  lib/widgets/question_widget.dart
//
//  Created by Denis Bystruev on 14/03/2020.
//

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_outfit/models/answer.dart';
import 'package:get_outfit/models/question.dart';
import 'package:get_outfit/models/question_type.dart';
import 'package:get_outfit/widgets/answer_image_widget.dart';
import 'package:get_outfit/widgets/checkbox_widget.dart';
import 'package:get_outfit/widgets/form_widget.dart';
import 'package:get_outfit/widgets/futura_widgets.dart';
import 'package:get_outfit/widgets/radio_widget.dart';
import 'package:get_outfit/widgets/slider_widget.dart';

class QuestionWidget extends StatelessWidget {
  static Map<int, TextEditingController> controllers = {};
  final void Function(Answer answer, {String label}) onAnswer;
  final int questionIndex;
  final Question question;
  final String sliderLabel;
  final double scale;

  QuestionWidget(
    this.questionIndex,
    this.question, {
    this.sliderLabel,
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
            controller: question.controller,
            hintText: question.title,
            keyboardType: question.keyboardType,
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
      case QuestionType.multiChoice:
        final List<Widget> checkboxButtons = buildButtons(
          (index, answer) => Padding(
            child: CheckboxWidget(
              index: index,
              label: FuturaBookText.normal(
                answer,
                fontSize: 14 * scale,
                textAlign: TextAlign.start,
              ),
              onSelected: (index, value) => onAnswer(
                Answer.setIndex(
                  index,
                  oldIndexes: question.givenAnswer?.indexes,
                  value: value,
                ),
              ),
              scale: scale,
              selected: question.givenAnswer?.indexes?.contains(index) == true,
            ),
            padding: EdgeInsets.only(bottom: 4 * scale),
          ),
        ).toList();
        return Padding(
          padding: EdgeInsets.fromLTRB(6 * scale, 12 * scale, 6 * scale, 0),
          child: Column(children: checkboxButtons),
        );
      case QuestionType.range:
        return Padding(
          child: SliderWidget(
            label: sliderLabel,
            max: question.maxValue,
            min: question.minValue,
            onChanged: (int value, String label) => onAnswer(
              Answer.value(value),
              label: label,
            ),
            scale: scale,
            value: question.givenAnswer.value,
          ),
          padding: EdgeInsets.only(bottom: 6 * scale, top: 10 * scale),
        );
      case QuestionType.singleChoice:
        final int selectedIndex = question.givenAnswer?.indexes?.first ?? 0;
        final Iterable<int> textLengts =
            question.answers.map((text) => text.length);
        final int allTextLength =
            textLengts.reduce((total, current) => total + current);
        final int maxTextLength = textLengts.reduce(max);
        final int numberOfAnswers = question.answers.length;
        final bool isTwoColumns = 6 < numberOfAnswers && maxTextLength < 21;
        final bool isVertical = numberOfAnswers < 3 ||
            5 < numberOfAnswers ||
            25 < allTextLength ||
            isTwoColumns;
        final List<Widget> radioButtons = buildButtons(
          (index, answer) => Padding(
            child: RadioWidget(
              groupValue: selectedIndex,
              label: FuturaBookText.normal(
                answer,
                fontSize: 14 * scale,
                textAlign: TextAlign.start,
              ),
              onChanged: (int value) => onAnswer(
                Answer.singleIndex(value),
              ),
              scale: scale,
              value: index,
            ),
            padding: EdgeInsets.only(bottom: 4 * scale),
          ),
        )
            .map(
              (widget) =>
                  isVertical ? widget : Flexible(child: widget, flex: 1),
            )
            .toList();
        final int halfLength = (radioButtons.length + 1) ~/ 2;
        return Padding(
          child: isTwoColumns
              ? Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: radioButtons.take(halfLength).toList(),
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Column(
                        children: radioButtons.skip(halfLength).toList(),
                      ),
                      flex: 3,
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                )
              : Flex(
                  children: radioButtons,
                  direction: isVertical ? Axis.vertical : Axis.horizontal,
                ),
          padding: EdgeInsets.fromLTRB(4 * scale, 12 * scale, 4 * scale, 0),
        );
      case QuestionType.text:
      default:
        final TextEditingController controller =
            controllers[question.id] ?? TextEditingController();
        controllers[question.id] = controller;
        final String newText = question.givenAnswer.text ?? '';
        if (controller.text != newText) controller.text = newText;
        return Padding(
          child: FormWidget.quiz(
            controller: controller,
            fontSize: 14 * scale,
            onChanged: (String newText) => onAnswer(
              Answer.text(newText),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8 * scale),
        );
    }
  }

  Iterable<Widget> buildButtons(
    Widget Function(int index, String answer) buttonWidget,
  ) =>
      question.answers
          .asMap()
          .map(
            (index, answer) => MapEntry(
              index,
              buttonWidget(index, answer),
            ),
          )
          .values;

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
                  Answer.invertIndex(
                    index,
                    oldIndexes: question.givenAnswer?.indexes,
                  ),
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
          Padding(
            child: FuturaMediumText.w500(
              question.title,
              fontSize: 16 * scale,
              textAlign: TextAlign.start,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8 * scale),
          ),
          question.subtitle == null
              ? null
              : Padding(
                  child: FuturaBookText.normal(
                    question.subtitle,
                    fontSize: 10 * scale,
                    textAlign: TextAlign.start,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8 * scale),
                ),
          question.isVisual ? buildImages() : buildAnswers(),
        ].where((element) => element != null).toList(),
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      padding: EdgeInsets.only(bottom: 20 * scale),
    );
  }
}
