// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answers _$AnswersFromJson(Map<String, dynamic> json) {
  return Answers(
    answers: (json['answers'] as List)?.map((e) => e as String)?.toList(),
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  );
}

Map<String, dynamic> _$AnswersToJson(Answers instance) => <String, dynamic>{
      'answers': instance.answers,
      'date': instance.date?.toIso8601String(),
    };
