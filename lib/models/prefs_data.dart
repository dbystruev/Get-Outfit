//
//  lib/models/prefs_data.dart
//
//  Created by Denis Bystruev on 28/05/2020.
//
//  https://flutter.dev/docs/development/data-and-backend/json

import 'package:get_outfit/models/answers.dart';
import 'package:get_outfit/models/app_data.dart';
import 'package:get_outfit/models/order.dart';
import 'package:get_outfit/models/plans.dart';
import 'package:get_outfit/models/questions.dart';
import 'package:get_outfit/models/server_data.dart';
import 'package:get_outfit/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prefs_data.g.dart';

@JsonSerializable(explicitToJson: true)
class PrefsData {
  static PrefsData _shared;
  static PrefsData get shared {
    if (_shared == null)
      _shared = PrefsData(
        plans: Plans.shared,
        questions: Questions.shared,
      );
    return _shared;
  }

  AppData appData;
  Plans plans;
  Questions questions;

  Answers get answers => serverData?.answers;
  void set answers(Answers newAnswers) => serverData == null
      ? serverData = ServerData(answers: newAnswers)
      : serverData.merge(
          ServerData(answers: newAnswers),
        );
  bool get hasData =>
      appData != null ||
      plans != null ||
      questions != null ||
      serverData != null;
  Order get order => serverData?.order;
  ServerData get serverData => appData?.serverData;
  void set serverData(ServerData newServerData) => appData == null
      ? appData = AppData(serverData: newServerData)
      : appData.merge(
          AppData(serverData: newServerData),
        );
  User get user => serverData?.user;

  PrefsData({this.appData, this.plans, this.questions});

  factory PrefsData.fromJson(Map<String, dynamic> json) =>
      _$PrefsDataFromJson(json);

  void merge(PrefsData prefsData) {
    if (prefsData == null) return;
    if (appData == null)
      appData = prefsData.appData;
    else
      appData.merge(prefsData.appData);
    plans = prefsData.plans ?? plans;
    questions = prefsData.questions ?? questions;
  }

  Map<String, dynamic> toJson() => _$PrefsDataToJson(this);

  @override
  String toString() =>
      'PrefsData(appData: $appData,\nplans: ${plans.plans.length},\nquestions: ${questions.length})';
}
