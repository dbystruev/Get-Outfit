//
//  lib/models/questions.dart
//
//  Created by Denis Bystruev on 23/04/2020.
//

// https://flutter.dev/docs/development/data-and-backend/json
import 'dart:math';
import 'package:get_outfit/models/answer.dart';
import 'package:get_outfit/models/answers.dart';
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
      expanded.any((question) => question.isValid) &&
      0 < minId &&
      maxId <= length;
  List<Question> get expanded =>
      questions.expand((questionList) => questionList).toList();
  Answers get givenAnswers => Answers(
        answers: expanded.map(
          (question) => question.givenAnswer.toString(),
        ),
      );
  void set givenAnswers(Answers answers) => expanded.forEach((question) {
    final int id = question.id;
    if (id == null) return;
    final int index = id - 1;
    if (index < 0 || answers.answers.length <= index) return;
    final String answer = answers.answers[index];
    question.givenAnswer = Answer.fromString(answer);
  });
  List<int> get ids => expanded.map((question) => question.id).toList();
  int get length => expanded.length;
  int get maxId => ids.reduce(max);
  int get minId => ids.reduce(min);
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
