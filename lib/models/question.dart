//
//  lib/models/question.dart
//
//  Created by Denis Bystruev on 14/03/2020.
//

// https://flutter.dev/docs/development/data-and-backend/json
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:get_outfit/models/question_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:get_outfit/models/answer.dart';
import 'package:get_outfit/models/gender.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class Question {
  static int _maxId = 0;
  static int get maxId => _maxId;

  final List<String> answers;

  @JsonKey(ignore: true)
  final TextEditingController controller;

  final Answer defaultAnswer;
  final Gender gender;
  Answer givenAnswer;
  final String hint;
  final int id;
  final bool isEnabled;
  final bool isVisual;

  @JsonKey(ignore: true)
  final TextInputType keyboardType;
  
  final int maxValue;
  final int minValue;
  final String subtitle;
  final String title;
  final QuestionType type;

  bool get isValid => id != null && 0 < id && id <= _maxId;
  List<String> get imageUrls => isVisual ? answers : [];

  Question(
    this.title, {
    this.answers,
    this.controller,
    this.defaultAnswer = const Answer.defaultIndex(),
    this.gender = Gender.both,
    Answer givenAnswer,
    this.hint,
    int id,
    bool isEnabled,
    this.isVisual = false,
    this.keyboardType,
    this.maxValue,
    this.minValue,
    this.subtitle,
    this.type = QuestionType.text,
  })  : this.givenAnswer = givenAnswer ?? defaultAnswer,
        this.id = id ?? ++_maxId,
        this.isEnabled = isEnabled ?? true {
    _maxId = max(this.id, _maxId);
  }

  factory Question.female(
    String title, {
    List<String> answers,
    Answer defaultAnswer,
    String hint,
    bool isDropdown,
    bool isVisual,
    int maxValue,
    int minValue,
    String subtitle,
    QuestionType type,
    int value,
  }) =>
      Question(
        title,
        answers: answers,
        defaultAnswer: defaultAnswer ?? const Answer.defaultIndex(),
        gender: Gender.female,
        hint: hint,
        isVisual: isVisual ?? false,
        maxValue: maxValue,
        minValue: minValue,
        subtitle: subtitle,
        type: type ?? QuestionType.text,
      );

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  factory Question.male(
    String title, {
    List<String> answers,
    Answer defaultAnswer,
    String hint,
    bool isDropdown,
    bool isVisual,
    int maxValue,
    int minValue,
    String subtitle,
    QuestionType type,
    int value,
  }) =>
      Question(
        title,
        answers: answers,
        defaultAnswer: defaultAnswer ?? const Answer.defaultIndex(),
        gender: Gender.male,
        hint: hint,
        isVisual: isVisual ?? false,
        maxValue: maxValue,
        minValue: minValue,
        subtitle: subtitle,
        type: type ?? QuestionType.text,
      );

  factory Question.header(String title, {Gender gender, String subtitle}) =>
      Question(
        title,
        gender: gender ?? Gender.both,
        subtitle: subtitle,
        type: QuestionType.header,
      );

  factory Question.headerFemale(
    String title, {
    Gender gender,
    String subtitle,
  }) =>
      Question.header(
        title,
        gender: Gender.female,
        subtitle: subtitle,
      );

  factory Question.headerMale(
    String title, {
    Gender gender,
    String subtitle,
  }) =>
      Question.header(
        title,
        gender: Gender.male,
        subtitle: subtitle,
      );

  factory Question.multiChoice(
    String title, {
    List<String> answers,
    Gender gender,
    String subtitle,
  }) =>
      Question(
        title,
        answers: answers,
        defaultAnswer: Answer.multiIndexes([]),
        gender: gender ?? Gender.both,
        subtitle: subtitle,
        type: QuestionType.multiChoice,
      );

  factory Question.multiChoiceFemale(
    String title, {
    List<String> answers,
    String subtitle,
  }) =>
      Question.multiChoice(
        title,
        answers: answers,
        gender: Gender.female,
        subtitle: subtitle,
      );

  factory Question.multiChoiceMale(
    String title, {
    List<String> answers,
    String subtitle,
  }) =>
      Question.multiChoice(
        title,
        answers: answers,
        gender: Gender.male,
        subtitle: subtitle,
      );

  factory Question.pictures(
    String title, {
    Gender gender,
    String subtitle,
    List<String> urls,
  }) =>
      Question(
        title,
        answers: urls,
        defaultAnswer: Answer.multiIndexes([]),
        gender: gender ?? Gender.both,
        isVisual: true,
        subtitle: subtitle,
        type: QuestionType.multiChoice,
      );

  factory Question.picturesFemale(
    String title, {
    String subtitle,
    List<String> urls,
  }) =>
      Question.pictures(
        title,
        gender: Gender.female,
        subtitle: subtitle,
        urls: urls,
      );

  factory Question.picturesMale(
    String title, {
    String subtitle,
    List<String> urls,
  }) =>
      Question.pictures(
        title,
        gender: Gender.male,
        subtitle: subtitle,
        urls: urls,
      );

  factory Question.range(
    String title,
    int minValue,
    int value,
    int maxValue, {
    Gender gender,
    String subtitle,
  }) =>
      Question(
        title,
        defaultAnswer: Answer.value(value),
        gender: gender ?? Gender.both,
        maxValue: maxValue,
        minValue: minValue,
        subtitle: subtitle,
        type: QuestionType.range,
      );

  factory Question.rangeFemale(
    String title,
    int minValue,
    int value,
    int maxValue, {
    String subtitle,
  }) =>
      Question.range(
        title,
        minValue,
        value,
        maxValue,
        gender: Gender.female,
        subtitle: subtitle,
      );

  factory Question.rangeMale(
    String title,
    int minValue,
    int value,
    int maxValue, {
    String subtitle,
  }) =>
      Question.range(
        title,
        minValue,
        value,
        maxValue,
        gender: Gender.male,
        subtitle: subtitle,
      );

  factory Question.singleChoice(
    String title, {
    List<String> answers,
    Answer defaultAnswer,
    Gender gender,
    String subtitle,
  }) =>
      Question(
        title,
        answers: answers,
        defaultAnswer: defaultAnswer ?? const Answer.defaultIndex(),
        gender: gender ?? Gender.both,
        subtitle: subtitle,
        type: QuestionType.singleChoice,
      );

  factory Question.singleChoiceFemale(
    String title, {
    List<String> answers,
    Answer defaultAnswer,
    String subtitle,
  }) =>
      Question.singleChoice(
        title,
        answers: answers,
        defaultAnswer: defaultAnswer ?? const Answer.defaultIndex(),
        gender: Gender.female,
        subtitle: subtitle,
      );

  factory Question.singleChoiceMale(
    String title, {
    List<String> answers,
    Answer defaultAnswer,
    String subtitle,
  }) =>
      Question.singleChoice(
        title,
        answers: answers,
        defaultAnswer: defaultAnswer ?? const Answer.defaultIndex(),
        gender: Gender.male,
        subtitle: subtitle,
      );

  factory Question.yesNo(
    String title, {
    Gender gender,
    String subtitle,
  }) =>
      Question.singleChoice(
        title,
        answers: ['Да', 'Нет'],
        gender: gender ?? Gender.both,
        subtitle: subtitle,
      );

  void dispose() => _maxId -= id == _maxId ? 1 : 0;

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  @override
  bool operator ==(dynamic other) {
    if (other == null ||
        !(other is Question) ||
        answers?.length != other.answers?.length) return false;
    if (answers != null)
      for (int index = 0; index < answers.length; index++)
        if (answers[index] != other.answers[index]) return false;
    return defaultAnswer == other.defaultAnswer &&
        gender == other.gender &&
        givenAnswer == other.givenAnswer &&
        hint == other.hint &&
        id == other.id &&
        isEnabled == other.isEnabled &&
        isVisual == other.isVisual &&
        maxValue == other.maxValue &&
        minValue == other.minValue &&
        subtitle == other.subtitle &&
        title == other.title &&
        type == other.type;
  }

  @override
  String toString() {
    return '''Question(
  '$title',
  answers: ${answers == null ? null : answers.map((answer) => '\'${answer}\'')},
  defaultAnswer: $defaultAnswer,
  gender: $gender,
  givenAnswer: $givenAnswer,
  hint: '$hint',
  id: $id,
  isEnabled: $isEnabled,
  isVisual: $isVisual,
  maxValue: $maxValue,
  minValue: $minValue,
  subtitle: '$subtitle',
  type: $type,
)''';
  }
}
