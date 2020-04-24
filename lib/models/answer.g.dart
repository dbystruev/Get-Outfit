// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) {
  return Answer(
    indexes: (json['indexes'] as List)?.map((e) => e as int)?.toList(),
    text: json['text'] as String,
    value: json['value'] as int,
  );
}

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'indexes': instance.indexes,
      'text': instance.text,
      'value': instance.value,
    };
