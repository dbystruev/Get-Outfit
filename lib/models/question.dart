//
//  lib/models/question.dart
//
//  Created by Denis Bystruev on 14/03/2020.
//

import 'package:get_outfit/models/answer.dart';
import 'package:get_outfit/models/gender.dart';

enum QuestionType {
  dropdown,
  header,
  inlineText,
  multiChoice,
  range,
  singleChoice,
  text
}

class Question {
  static int _maxId = 1;
  static int get maxId => _maxId;

  final List<String> answers;
  final Answer defaultAnswer;
  final Gender gender;
  Answer givenAnswer;
  final String hint;
  final int id;
  final bool isVisual;
  final int maxValue;
  final int minValue;
  final String subtitle;
  final String title;
  List<String> get imageUrls => isVisual ? answers : [];
  final QuestionType type;
  final int value;

  Question(
    this.title, {
    this.answers,
    this.defaultAnswer = const Answer.defaultIndex(),
    this.gender = Gender.both,
    Answer givenAnswer,
    this.hint,
    this.isVisual = false,
    this.maxValue,
    this.minValue,
    List<int> selectedAnswers,
    this.subtitle,
    this.type = QuestionType.text,
    this.value,
  })  : this.givenAnswer = givenAnswer ?? defaultAnswer,
        this.id = _maxId++;

  factory Question.dropdown(
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
        type: QuestionType.dropdown,
      );

  factory Question.dropdownFemale(
    String title, {
    List<String> answers,
    Answer defaultAnswer,
    String subtitle,
  }) =>
      Question.dropdown(
        title,
        answers: answers,
        defaultAnswer: defaultAnswer ?? const Answer.defaultIndex(),
        gender: Gender.female,
        subtitle: subtitle,
      );

  factory Question.dropdownMale(
    String title, {
    List<String> answers,
    Answer defaultAnswer,
    String subtitle,
  }) =>
      Question.dropdown(
        title,
        answers: answers,
        defaultAnswer: defaultAnswer ?? const Answer.defaultIndex(),
        gender: Gender.male,
        subtitle: subtitle,
      );

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
        value: value,
      );

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
        value: value,
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
        defaultAnswer: Answer.multi([]),
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
        gender: gender ?? Gender.both,
        maxValue: maxValue,
        minValue: minValue,
        subtitle: subtitle,
        type: QuestionType.range,
        value: value,
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
    Gender gender,
    String subtitle,
  }) =>
      Question(
        title,
        answers: answers,
        gender: gender ?? Gender.both,
        subtitle: subtitle,
        type: QuestionType.singleChoice,
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

  @override
  String toString() => '''{
  'title': $title,
  'answers': $answers,
  'defaultAnswer': $defaultAnswer,
  'gender': $gender,
  'hint': $hint,
  'id': $id,
  'isVisual': $isVisual,
  'maxValue': $maxValue,
  'minValue': $minValue,
  'subtitle': $subtitle,
  'type': $type,
  'value': $value,
}''';
}
