//
//  lib/models/answers.dart
//
//  Created by Denis Bystruev on 11/06/2020.
//

// https://flutter.dev/docs/development/data-and-backend/json
import 'package:json_annotation/json_annotation.dart';

part 'answers.g.dart';

@JsonSerializable()
class Answers {
  static final Answers shared = Answers();

  List<String> answers;
  final DateTime date;

  Answers({List<String> answers, DateTime date})
      : this.answers = answers ?? const [],
        this.date = date ?? DateTime.now();

  factory Answers.fromJson(Map<String, dynamic> json) =>
      _$AnswersFromJson(json);

  Map<String, dynamic> toJson() => _$AnswersToJson(this);

  void merge(Answers answers) {
    final length = answers?.answers?.length;
    if (length == null) return;
    if (length != this.answers?.length) {
      this.answers = answers.answers;
      return;
    }
    for (int index = 0; index < length; index++)
      this.answers[index] = answers.answers[index] ?? this.answers[index];
  }
}
