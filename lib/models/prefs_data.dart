//
//  lib/models/prefs_data.dart
//
//  Created by Denis Bystruev on 28/05/2020.
//
//  https://flutter.dev/docs/development/data-and-backend/json

import 'package:get_outfit/models/answer.dart';
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
  static final PrefsData shared = PrefsData(
    plans: Plans.shared,
    questions: Questions.shared,
  );

  AppData appData;
  Plans plans;
  Questions questions;

  List<Answer> get answers => serverData?.answers;
  bool get hasData =>
      appData != null ||
      plans != null ||
      questions != null ||
      serverData != null;
  Order get order => serverData?.order;
  ServerData get serverData => appData?.serverData;
  User get user => serverData?.user;

  PrefsData({this.appData, this.plans, this.questions});

  factory PrefsData.fromJson(Map<String, dynamic> json) =>
      _$PrefsDataFromJson(json);

  void merge(PrefsData prefsData) {
    if (appData == null)
      appData = prefsData?.appData;
    else
      appData.merge(prefsData?.appData);
    plans = prefsData?.plans ?? plans;
    questions = prefsData?.questions ?? questions;
  }

  Map<String, dynamic> toJson() => _$PrefsDataToJson(this);

  @override
  String toString() =>
      'PrefsData(appData: $appData,\nplans: ${plans.plans.length},\nquestions: ${questions.length})';
}
