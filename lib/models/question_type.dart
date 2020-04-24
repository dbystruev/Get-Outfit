//
//  lib/models/question_type.dart
//
//  Created by Denis Bystruev on 24/04/2020.
//

// https://flutter.dev/docs/development/data-and-backend/json
import 'package:json_annotation/json_annotation.dart';

enum QuestionType {
  @JsonValue('Header')
  header,

  @JsonValue('Inline Text')
  inlineText,

  @JsonValue('Multi Choice')
  multiChoice,

  @JsonValue('Range')
  range,

  @JsonValue('Single Choice')
  singleChoice,

  @JsonValue('Text')
  text,
}

extension QuestionTypeExtension on QuestionType {
  QuestionType() { }
}
