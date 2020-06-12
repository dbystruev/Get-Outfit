//
//  lib/screens/quiz_screen.dart
//
//  Created by Denis Bystruev on 12/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/controllers/network_controller.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/models/answers.dart';
import 'package:get_outfit/models/app_data.dart';
import 'package:get_outfit/models/gender.dart';
import 'package:get_outfit/models/prefs_data.dart';
import 'package:get_outfit/models/question.dart';
import 'package:get_outfit/models/questions.dart';
import 'package:get_outfit/models/server_data.dart';
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
  final Questions allQuestions = PrefsData.shared.questions;
  final ScrollController controller = ScrollController();
  final Gender gender;
  bool savingAnswers = false;
  Map<int, String> sliderLabels = {};
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
              controller: controller,
              itemBuilder: (BuildContext context, int index) => QuestionWidget(
                index,
                questions[pageIndex][index],
                onAnswer: (answer, {String label}) {
                  setState(() {
                    questions[pageIndex][index].givenAnswer = answer;
                    sliderLabels[questions[pageIndex][index].id] = label;
                  });
                },
                scale: scale,
                sliderLabel: sliderLabels[questions[pageIndex][index].id],
              ),
              itemCount: questions[pageIndex].length,
            ),
            padding: EdgeInsets.symmetric(horizontal: 22 * scale),
          ),
        ),
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

  void decrementPage() => incrementPageBy(-1);

  @override
  void didChangeDependencies() {
    precacheImages();
    super.didChangeDependencies();
  }

  void incrementPage() => incrementPageBy(1);

  void incrementPageBy(int increment) {
    pageIndex += increment;
    controller.animateTo(
      0,
      curve: Curves.decelerate,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void initState() {
    questions = allQuestions.questions
        .map(
          (questionPage) => questionPage
              .where(
                (question) =>
                    question.isEnabled &&
                    (question.gender == gender ||
                        question.gender == Gender.both),
              )
              .toList(),
        )
        .toList();
    super.initState();
  }

  void onLeftPressed() {
    saveAnswers();
    if (pageIndex < 1)
      Navigator.pop(context);
    else {
      setState(decrementPage);
    }
  }

  void onRightPressed() async {
    if (pageIndex + 1 < questions.length) {
      saveAnswers();
      setState(incrementPage);
    } else {
      while (savingAnswers)
        await Future.delayed(
          Duration(milliseconds: 100),
        );
      saveAnswers();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => PlansScreen(),
        ),
      );
    }
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

  // Save answers to prefs and the server
  void saveAnswers() async {
    if (savingAnswers) return;
    savingAnswers = true;
    final int length = allQuestions.length;
    List<String> answerList = List<String>(length);
    for (int index = 0; index < length; index++) {
      final question = allQuestions.expanded[index];
      answerList[question.id - 1] = question.givenAnswer?.toString();
    }
    await NetworkController.shared.savePrefsData(
      PrefsData(
        appData: AppData(
          serverData: ServerData(
            answers: Answers(answers: answerList),
          ),
        ),
        questions: allQuestions,
      ),
    );
    await NetworkController.shared.postAnswers().catchError(
          (error) => debugPrint(
            'ERROR in lib/screens/quiz_screen.dart:179 saveAnswers() ' +
                error.toString(),
          ),
        );
    savingAnswers = false;
  }
}
