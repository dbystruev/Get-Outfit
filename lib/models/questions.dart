//
//  lib/models/questions.dart
//
//  Created by Denis Bystruev on 23/04/2020.
//

// https://flutter.dev/docs/development/data-and-backend/json
import 'package:get_outfit/models/question+all.dart';
import 'package:get_outfit/models/question.dart';
import 'package:json_annotation/json_annotation.dart';
part 'questions.g.dart';

@JsonSerializable(explicitToJson: true)
class Questions {
  static final Questions shared = Questions(AllQuestions.local);

  String message;
  List<List<Question>> questions;
  String status;
  int time;

  bool get areValid =>
      questions != null &&
      questions.any(
        (questionPage) => questionPage.any(
          (question) => question.isValid,
        ),
      );
  int get length => questions.expand((questionList) => questionList).length;
  String get version => versionDynamic.toString();

  @JsonKey(name: 'version')
  dynamic versionDynamic;

  Questions(
    this.questions, {
    this.message,
    this.time,
    this.status,
    this.versionDynamic,
  });

  factory Questions.fromJson(Map<String, dynamic> json) =>
      _$QuestionsFromJson(json);

  void merge(Questions newQuestions) {
    questions = newQuestions?.questions ?? questions;
    message = newQuestions?.message ?? message;
    time = newQuestions?.time ?? time;
    status = newQuestions?.status ?? status;
    versionDynamic = newQuestions?.versionDynamic ?? versionDynamic;
  }

  Map<String, dynamic> toJson() => _$QuestionsToJson(this);

  @override
  String toString() =>
      '\n$length Questions(' +
      'message: \'$message\', ' +
      'status: \'$status\', ' +
      'time: \'$time\', ' +
      'versionDynamic: \'$version\')';
}
