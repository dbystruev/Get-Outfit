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
import 'package:get_outfit/models/questions.dart';
import 'package:get_outfit/screens/login_screen.dart';
import 'package:get_outfit/widgets/futura_widgets.dart';

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
      plans = await getPlans(token: appData.token, url: appData.plansUrl);
      questions =
          await getQuestions(token: appData.token, url: appData.plansUrl);
    } else {
      plans = Plans([], message: appData.message, status: appData.status);
      questions =
          Questions([], message: appData.message, status: appData.status);
    }
    if (!plans.isValid) {
      plans.plans = AllPlans.local;
      debugPrint(
        'ERROR in lib/screens/launch_screen.dart line 68: ' +
            '${plans.status}' +
            '\nmessage = ${plans.message}',
      );
    }
    if (!questions.isValid) {
      questions.questions = AllQuestions.local;
      debugPrint(
        'ERROR in lib/screens/launch_screen.dart line 76: ' +
            '${questions.status}' +
            '\nmessage = ${questions.message}',
      );
    }
  }

  Future<Plans> getPlans({String token, String url}) async {
    Plans plans = await networkController.getPlans(
      token: token,
      url: url,
    );
    if (plans.status == globals.statusSuccess) return plans;
    return Plans([], status: plans.status, message: plans.message);
  }

  Future<Questions> getQuestions({String token, String url}) async {
    Questions questions = await networkController.getQuestions(
      token: token,
      url: url,
    );
    if (questions.status == globals.statusSuccess) return questions;
    return Questions([], status: questions.status, message: questions.message);
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
}
