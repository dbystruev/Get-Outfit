//
//  lib/screens/quiz_screen.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/models/gender.dart';
import 'package:get_outfit/models/question.dart';
import 'package:get_outfit/models/question+all.dart';
import 'package:get_outfit/screens/plans_screen.dart';
import 'package:get_outfit/widgets/footer_widget.dart';
import 'package:get_outfit/widgets/question_widget.dart';

class QuizScreen extends StatefulWidget {
  final Gender gender;

  QuizScreen(this.gender);

  @override
  _QuizScreenState createState() => _QuizScreenState(gender);
}

class _QuizScreenState extends State<QuizScreen> with Scale {
  final List<List<Question>> allQuestions = AllQuestions.local;
  final Gender gender;
  int pageIndex = 0;
  List<List<Question>> questions;
  bool precachedImages = false;

  _QuizScreenState(this.gender);

  @override
  Widget build(BuildContext context) {
    final double scale = getScale(context);
    return Scaffold(
      body: GestureDetector(
        child: SafeArea(
          child: Padding(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) => QuestionWidget(
                index,
                questions[pageIndex][index],
                onAnswer: (answer) {
                  setState(
                      () => questions[pageIndex][index].givenAnswer = answer);
                },
                scale: scale,
              ),
              itemCount: questions[pageIndex].length,
            ),
            padding: EdgeInsets.symmetric(horizontal: 30 * scale),
          ),
        ),
        onHorizontalDragEnd: (DragEndDetails details) {
          if (0 < details.velocity.pixelsPerSecond.dx)
            onLeftPressed();
          else
            onRightPressed();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: FooterWidget(
          leftText: pageIndex < 1 ? null : 'Назад',
          middleText: '${pageIndex + 1} из ${questions.length}',
          onLeftPressed: onLeftPressed,
          onRightPressed: onRightPressed,
          rightText: pageIndex + 1 < questions.length ? 'Далее' : 'Готово',
          scale: scale,
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    precacheImages();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    questions = allQuestions
        .map(
          (questionPage) => questionPage
              .where(
                (question) =>
                    question.gender == gender || question.gender == Gender.both,
              )
              .toList(),
        )
        .toList();
    super.initState();
  }

  void onLeftPressed() {
    if (pageIndex < 1)
      Navigator.pop(context);
    else
      setState(() => pageIndex--);
  }

  void onRightPressed() {
    if (pageIndex + 1 < questions.length)
      setState(() => pageIndex++);
    else
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => PlansScreen(),
        ),
      );
  }

  void precacheImages() {
    if (precachedImages) return;
    precachedImages = true;
    questions.expand((questionPage) => questionPage).forEach((question) {
      if (question.isVisual)
        question.imageUrls.forEach(
          (url) => precacheImage(NetworkImage(url), context),
        );
    });
  }
}
