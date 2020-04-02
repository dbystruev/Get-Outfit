//
//  lib/screens/quiz.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/models/gender.dart';
import 'package:get_outfit/models/question.dart';
import 'package:get_outfit/models/question+all.dart';
import 'package:get_outfit/screens/plans.dart';
import 'package:get_outfit/widgets/footer.dart';
import 'package:get_outfit/widgets/question.dart';

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

  _QuizScreenState(this.gender);

  @override
  Widget build(BuildContext context) {
    print('DEBUG in lib/screens/quiz.dart line 34: _QuizScreenState.build');
    final List<Question> questions = allQuestions[pageIndex]
        .where(
          (question) =>
              question.gender == gender || question.gender == Gender.both,
        )
        .toList();
    final double scale = getScale(context);
    return Scaffold(
      body: GestureDetector(
        child: SafeArea(
          child: Padding(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  QuestionWidget(index, questions[index], scale: scale),
              itemCount: questions.length,
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
          leftText: pageIndex < 1 ? 'Для кого' : 'Назад',
          middleText: '${pageIndex + 1} из ${allQuestions.length}',
          onLeftPressed: onLeftPressed,
          onRightPressed: onRightPressed,
          rightText: pageIndex + 1 < allQuestions.length ? 'Далее' : 'Готово',
          scale: scale,
        ),
      ),
    );
  }

  void onLeftPressed() {
    if (pageIndex < 1)
      Navigator.pop(context);
    else
      setState(() => pageIndex--);
  }

  void onRightPressed() {
    if (pageIndex + 1 < allQuestions.length)
      setState(() => pageIndex++);
    else
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => PlansScreen(),
        ),
      );
  }
}
