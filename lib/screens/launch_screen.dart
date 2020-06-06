//
//  lib/screens/launch_screen.dart
//
//  Created by Denis Bystruev on 09/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/controllers/network_controller.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/globals.dart' as globals;
import 'package:get_outfit/models/app_data.dart';
import 'package:get_outfit/models/plans.dart';
import 'package:get_outfit/models/prefs_data.dart';
import 'package:get_outfit/models/question.dart';
import 'package:get_outfit/models/questions.dart';
import 'package:get_outfit/screens/login_screen.dart';
import 'package:get_outfit/widgets/futura_widgets.dart';
import 'package:http/http.dart' as http;

class LaunchScreen extends StatelessWidget with Scale {
  static bool built = false;
  final NetworkController networkController = NetworkController.shared;
  final DateTime startTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    if (!built) {
      built = true;
      navigateToLoginScreen(context, delayInSeconds: 2);
    }
    final double scale = getScale(context);
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Column(
            children: <Widget>[
              FuturaText.bold('GET OUTFIT', fontSize: 42 * scale),
              SizedBox(height: 20 * scale),
              FuturaMediumText.w500(
                'Выглядеть стильно\nтеперь просто',
                fontSize: 22 * scale,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        onTap: () {
          navigateToLoginScreen(context);
        },
      ),
    );
  }

  void getAppData() async {
    final AppData appData = await networkController.getAppData();
    Plans plans;
    Questions questions;
    if (appData.status == globals.statusSuccess) {
      await networkController.savePrefsData(
        PrefsData(appData: appData),
      );
      plans = await networkController.getPlans(
        appData.plansUrl,
        token: appData.token,
      );
      questions = await networkController.getQuestions(
        appData.plansUrl,
        token: appData.token,
      );
    } else {
      debugPrint(
        'DEBUG in lib/screens/launch_screen.dart:72 getAppData()' +
            ' status is not ${globals.statusSuccess}, appData = $appData',
      );
      plans = Plans([], message: appData.message, status: appData.status);
      questions =
          Questions([], message: appData.message, status: appData.status);
    }
    if (!plans.areValid) {
      debugPrint(
        'ERROR in lib/screens/launch_screen.dart:81 getAppData() plans are not valid',
      );
    }
    // matchQuestionPages(
    //   loadedQuestions: questions.questions,
    //   localQuestions: allQuestions,
    // );
    if (questions.areValid) {
      networkController.savePrefsData(
        PrefsData(questions: questions),
      );
      debugPrint(
        'DEBUG in lib/screens/launch_screen.dart:93 getAppData()' +
            ' ${questions.length} questions' +
            ' are loaded in ${DateTime.now().difference(startTime)}',
      );
      networkController.createNewUser(appData);
    } else {
      debugPrint(
        'DEBUG in lib/screens/launch_screen.dart:100 questions are not valid' +
            ', appData = $appData, questions = $questions',
      );
      // questions.questions = allQuestions;
      // postQuestions(appData: appData, questions: questions);
    }
  }

  // Match local questions with loaded questions
  void matchQuestionPages({
    List<List<Question>> loadedQuestions,
    List<List<Question>> localQuestions,
  }) {
    if (loadedQuestions?.length == localQuestions.length) {
      debugPrint(
        'DEBUG in lib/screens/launch_screen.dart:115' +
            ' matchQuestionPages() ${loadedQuestions.length} pages',
      );
      for (int pageIndex = 0; pageIndex < loadedQuestions.length; pageIndex++) {
        if (loadedQuestions[pageIndex].length ==
            localQuestions[pageIndex].length) {
          debugPrint(
            '\tPage $pageIndex: ${loadedQuestions[pageIndex].length} questions',
          );
          for (int questionIndex = 0;
              questionIndex < localQuestions[pageIndex].length;
              questionIndex++) {
            matchQuestions(
              questionIndex,
              loadedQuestion: loadedQuestions[pageIndex][questionIndex],
              localQuestion: localQuestions[pageIndex][questionIndex],
            );
          }
        } else {
          debugPrint(
            '\tThe number of questions on page $pageIndex does not match:' +
                '\n\t\tloadedQuestions[$pageIndex].length = ${loadedQuestions[pageIndex].length}' +
                '\n\t\tlocalQuestions[$pageIndex].length = ${localQuestions[pageIndex].length}',
          );
        }
      }
    } else {
      debugPrint(
        'DEBUG in lib/screens/launch_screen.dart:143 The number of pages does not match:' +
            '\n\tloadedQuestions.length = ${loadedQuestions?.length}' +
            '\n\tlocalQuestions.length = ${localQuestions.length}',
      );
    }
  }

  void matchQuestions(
    int questionIndex, {
    Question loadedQuestion,
    Question localQuestion,
  }) {
    // debugPrint(
    //   'matchQuestions($questionIndex, $loadedQuestion, $localQuestion)',
    // );
    if (loadedQuestion == localQuestion) return;
    debugPrint('\t\tQuestion $questionIndex does not match');
    if (loadedQuestion.answers != localQuestion.answers) {
      debugPrint('\t\t\tanswers do not match');
      if (loadedQuestion.answers.length != localQuestion.answers.length) {
        debugPrint(
            '\t\t\t\tloadedQuestion.answers.length = ${loadedQuestion.answers.length}');
        debugPrint(
            '\t\t\t\localQuestion.answers.length = ${localQuestion.answers.length}');
      } else {
        for (int answerIndex = 0;
            answerIndex < localQuestion.answers.length;
            answerIndex++) {
          if (loadedQuestion.answers[answerIndex] !=
              localQuestion.answers[answerIndex]) {
            debugPrint(
                '\t\t\t\tloadedQuestion.answers[answerIndex] = ${loadedQuestion.answers[answerIndex]}');
            debugPrint(
                '\t\t\t\tlocalQuestion.answers[answerIndex] = ${localQuestion.answers[answerIndex]}');
          }
        }
      }
    }
    if (loadedQuestion.defaultAnswer != localQuestion.defaultAnswer) {
      debugPrint('\t\t\tdefaultAnswer do not match');
      debugPrint(
          '\t\t\t\tloadedQuestion.defaultAnswer = ${loadedQuestion.defaultAnswer}');
      debugPrint(
          '\t\t\t\tlocalQuestion.defaultAnswer = ${localQuestion.defaultAnswer}');
    }
    if (loadedQuestion.gender != localQuestion.gender) {
      debugPrint('\t\t\tgender do not match');
      debugPrint('\t\t\t\tloadedQuestion.gender = ${loadedQuestion.gender}');
      debugPrint('\t\t\t\tlocalQuestion.gender = ${localQuestion.gender}');
    }
    if (loadedQuestion.givenAnswer != localQuestion.givenAnswer) {
      debugPrint('\t\t\tgivenAnswer do not match');
      debugPrint(
          '\t\t\t\tloadedQuestion.givenAnswer = ${loadedQuestion.givenAnswer}');
      debugPrint(
          '\t\t\t\tlocalQuestion.givenAnswer = ${localQuestion.givenAnswer}');
    }
    if (loadedQuestion.hint != localQuestion.hint) {
      debugPrint('\t\t\thint do not match');
      debugPrint('\t\t\t\tloadedQuestion.hint = ${loadedQuestion.hint}');
      debugPrint('\t\t\t\tlocalQuestion.hint = ${localQuestion.hint}');
    }
    if (loadedQuestion.id != localQuestion.id) {
      debugPrint('\t\t\tid do not match');
      debugPrint('\t\t\t\tloadedQuestion.id = ${loadedQuestion.id}');
      debugPrint('\t\t\t\tlocalQuestion.id = ${localQuestion.id}');
    }
    if (loadedQuestion.isEnabled != localQuestion.isEnabled) {
      debugPrint('\t\t\tisEnabled do not match');
      debugPrint(
          '\t\t\t\tloadedQuestion.isEnabled = ${loadedQuestion.isEnabled}');
      debugPrint(
          '\t\t\t\tlocalQuestion.isEnabled = ${localQuestion.isEnabled}');
    }
    if (loadedQuestion.isVisual != localQuestion.isVisual) {
      debugPrint('\t\t\tisVisual do not match');
      debugPrint(
          '\t\t\t\tloadedQuestion.isVisual = ${loadedQuestion.isVisual}');
      debugPrint('\t\t\t\tlocalQuestion.isVisual = ${localQuestion.isVisual}');
    }
    if (loadedQuestion.maxValue != localQuestion.maxValue) {
      debugPrint('\t\t\tmaxValue do not match');
      debugPrint(
          '\t\t\t\tloadedQuestion.maxValue = ${loadedQuestion.maxValue}');
      debugPrint('\t\t\t\tlocalQuestion.maxValue = ${localQuestion.maxValue}');
    }
    if (loadedQuestion.minValue != localQuestion.minValue) {
      debugPrint('\t\t\tminValue do not match');
      debugPrint(
          '\t\t\t\tloadedQuestion.minValue = ${loadedQuestion.minValue}');
      debugPrint('\t\t\t\tlocalQuestion.minValue = ${localQuestion.minValue}');
    }
    if (loadedQuestion.subtitle != localQuestion.subtitle) {
      debugPrint('\t\t\tsubtitle do not match');
      debugPrint(
          '\t\t\t\tloadedQuestion.subtitle = ${loadedQuestion.subtitle}');
      debugPrint('\t\t\t\tlocalQuestion.subtitle = ${localQuestion.subtitle}');
    }
    if (loadedQuestion.title != localQuestion.title) {
      debugPrint('\t\t\ttitle do not match');
      debugPrint('\t\t\t\tloadedQuestion.title = ${loadedQuestion.title}');
      debugPrint('\t\t\t\tlocalQuestion.title = ${localQuestion.title}');
    }
    if (loadedQuestion.type != localQuestion.type) {
      debugPrint('\t\t\ttype do not match');
      debugPrint('\t\t\t\tloadedQuestion.type = ${loadedQuestion.type}');
      debugPrint('\t\t\t\tlocalQuestion.type = ${localQuestion.type}');
    }
  }

  void navigateToLoginScreen(
    BuildContext context, {
    int delayInSeconds = 0,
  }) async {
    final DateTime startTime = DateTime.now();
    final Duration waitDuration = Duration(seconds: delayInSeconds);
    // await networkController.removePrefsData(); // DEBUG: remove in release
    await networkController.getPrefsData();
    getAppData();
    final Duration elapsedTime = DateTime.now().difference(startTime);
    if (elapsedTime < waitDuration)
      await Future.delayed(waitDuration - elapsedTime);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  void postQuestions({AppData appData, Questions questions}) async {
    http.Response result = await networkController.postQuestions(
      questions,
      token: appData.token,
      url: appData.quizUrl,
    );
    int statusCode = result.statusCode;
    String url = result.headers['location'];
    int count = 0;
    while (300 <= statusCode && statusCode < 400 && ++count < 10) {
      result = await http.get(url);
      statusCode = result.statusCode;
      url = result.headers['location'];
    }
    debugPrint(
      'DEBUG in lib/screens/launch_screen.dart:288 postQuestions()' +
          '\n\tstatusCode = $statusCode' +
          '\n\theaders = ${result.headers}' +
          // '\n\tbody = ${result.body}' +
          '\n\tcount = $count',
    );
  }
}
