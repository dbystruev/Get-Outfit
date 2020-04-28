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
import 'package:get_outfit/models/plan+all.dart';
import 'package:get_outfit/models/plans.dart';
import 'package:get_outfit/models/question+all.dart';
import 'package:get_outfit/models/question.dart';
import 'package:get_outfit/models/questions.dart';
import 'package:get_outfit/screens/login_screen.dart';
import 'package:get_outfit/widgets/futura_widgets.dart';
import 'package:http/http.dart' as http;

class LaunchScreen extends StatelessWidget with Scale {
  static bool built = false;
  final NetworkController networkController = NetworkController();

  @override
  Widget build(BuildContext context) {
    if (!built) {
      built = true;
      navigateWithDelay(context, 3);
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
          navigateWithDelay(context, 0);
        },
      ),
    );
  }

  void getAppData() async {
    AppData appData = await networkController.getAppData();
    Plans plans;
    Questions questions;
    if (appData.status == globals.statusSuccess) {
      plans = await networkController.getPlans(
        token: appData.token,
        url: appData.plansUrl,
      );
      questions = await networkController.getQuestions(
        appData.plansUrl,
        token: appData.token,
      );
    } else {
      plans = Plans([], message: appData.message, status: appData.status);
      questions =
          Questions([], message: appData.message, status: appData.status);
    }
    // matchQuestions(questions.questions, AllQuestions.local);
    if (!plans.isValid) plans.plans = AllPlans.local;
    if (!questions.isValid) {
      questions.questions = AllQuestions.local;
      // postQuestions(appData: appData, questions: questions);
    }
  }

  void matchQuestions(
      List<List<Question>> questions, List<List<Question>> localQuestions) {
    debugPrint(
      'DEBUG in questions.length = ${questions.length}' +
          '\n  localQuestions.length = ${localQuestions.length}',
    );
    if (questions.length == localQuestions.length) {
      for (int index = 0; index < questions.length; index++) {
        debugPrint(
          '    questions[$index].length = ${questions[index].length}' +
              '\n    AllQuestions[$index].length = ${localQuestions[index].length}',
        );
        if (questions[index].length ==
            localQuestions[index].length) {
          for (int secondIndex = 0;
              secondIndex < localQuestions[index].length;
              secondIndex++) {
            final Question question = questions[index][secondIndex];
            final Question localQuestion =
                localQuestions[index][secondIndex];
            // if (question != localQuestion)
            //   debugPrint(
            //     '\n      [$index][$secondIndex] ${question.title} do not match',
            //   );
          }
        }
      }
    }
  }

  void navigateWithDelay(BuildContext context, int seconds) async {
    final duration = Duration(seconds: seconds);
    getAppData();
    await Future.delayed(duration);
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
      'DEBUG in lib/screens/launch_screen.dart line 109: POST result' +
          '\n  statusCode = $statusCode' +
          '\n  headers = ${result.headers}' +
          // '\n  body = ${result.body}' +
          '\n  count = $count',
    );
  }
}
