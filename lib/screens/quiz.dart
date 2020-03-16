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
    final List<Question> questions = allQuestions[pageIndex]
        .where(
          (question) =>
              question.gender == gender || question.gender == Gender.both,
        )
        .toList();
    print('DEBUG in lib/screens/quiz.dart line 25: _QuizScreenState.build');
    final double scale = getScale(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                QuestionWidget(questions[index], scale: scale),
            itemCount: questions.length,
          ),
          padding: EdgeInsets.symmetric(horizontal: 30 * scale),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: FooterWidget(
          leftText: pageIndex < 1 ? 'Для кого' : 'Назад',
          middleText: '${pageIndex + 1} из ${allQuestions.length}',
          onLeftPressed: () {
            print('DEBUG in lib/screens/questions.dart line 43: back pressed');
            if (pageIndex < 1)
              Navigator.pop(context);
            else
              setState(() => pageIndex--);
          },
          onRightPressed: () {
            print('DEBUG in lib/screens/questions.dart line 50: next pressed');
            setState(() => pageIndex++);
          },
          rightText: pageIndex + 1 < allQuestions.length ? 'Далее' : null,
          scale: scale,
        ),
      ),
    );
  }
}
