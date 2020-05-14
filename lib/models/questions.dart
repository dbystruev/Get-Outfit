//
//  lib/models/questions.dart
//
//  Created by Denis Bystruev on 23/04/2020.
//

// https://flutter.dev/docs/development/data-and-backend/json
import 'package:get_outfit/models/question.dart';
import 'package:json_annotation/json_annotation.dart';
part 'questions.g.dart';

@JsonSerializable(explicitToJson: true)
class Questions {
  bool get areValid =>
      questions != null &&
      questions.any(
        (questionPage) => questionPage.any(
          (question) => question.isValid,
        ),
      );
  final String message;
  List<List<Question>> questions;
  final String status;
  final int time;
  String get version => versionDynamic.toString();

  @JsonKey(name: 'version')
  final dynamic versionDynamic;

  Questions(
    this.questions, {
    this.message,
    this.time,
    this.status,
    this.versionDynamic,
  });

  factory Questions.fromJson(Map<String, dynamic> json) =>
      _$QuestionsFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionsToJson(this);

  @override
  String toString() =>
      '\nQuestions($questions, ' +
      'message: \'$message\', ' +
      'status: \'$status\', ' +
      'time: \'$time\', ' +
      'versionDynamic: \'$version\')';
}
