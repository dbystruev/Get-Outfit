// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Questions _$QuestionsFromJson(Map<String, dynamic> json) {
  return Questions(
    (json['questions'] as List)
        ?.map((e) => (e as List)
            ?.map((e) =>
                e == null ? null : Question.fromJson(e as Map<String, dynamic>))
            ?.toList())
        ?.toList(),
    message: json['message'] as String,
    status: json['status'] as String,
    versionDynamic: json['version'],
  );
}

Map<String, dynamic> _$QuestionsToJson(Questions instance) => <String, dynamic>{
      'message': instance.message,
      'questions': instance.questions
          ?.map((e) => e?.map((e) => e?.toJson())?.toList())
          ?.toList(),
      'status': instance.status,
      'version': instance.versionDynamic,
    };
