// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    json['title'] as String,
    answers: (json['answers'] as List)?.map((e) => e as String)?.toList(),
    defaultAnswer: json['defaultAnswer'] == null
        ? null
        : Answer.fromJson(json['defaultAnswer'] as Map<String, dynamic>),
    gender: _$enumDecodeNullable(_$GenderEnumMap, json['gender']),
    givenAnswer: json['givenAnswer'] == null
        ? null
        : Answer.fromJson(json['givenAnswer'] as Map<String, dynamic>),
    hint: json['hint'] as String,
    id: json['id'] as int,
    isEnabled: json['isEnabled'] as bool,
    isVisual: json['isVisual'] as bool,
    maxValue: json['maxValue'] as int,
    minValue: json['minValue'] as int,
    subtitle: json['subtitle'] as String,
    type: _$enumDecodeNullable(_$QuestionTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'answers': instance.answers,
      'defaultAnswer': instance.defaultAnswer?.toJson(),
      'gender': _$GenderEnumMap[instance.gender],
      'givenAnswer': instance.givenAnswer?.toJson(),
      'hint': instance.hint,
      'id': instance.id,
      'isEnabled': instance.isEnabled,
      'isVisual': instance.isVisual,
      'maxValue': instance.maxValue,
      'minValue': instance.minValue,
      'subtitle': instance.subtitle,
      'title': instance.title,
      'type': _$QuestionTypeEnumMap[instance.type],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$GenderEnumMap = {
  Gender.both: 'both',
  Gender.female: 'female',
  Gender.male: 'male',
};

const _$QuestionTypeEnumMap = {
  QuestionType.header: 'Header',
  QuestionType.inlineText: 'Inline Text',
  QuestionType.multiChoice: 'Multi Choice',
  QuestionType.range: 'Range',
  QuestionType.singleChoice: 'Single Choice',
  QuestionType.text: 'Text',
};
