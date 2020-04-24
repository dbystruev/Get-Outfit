// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    feedbackUrl: json['feedbackUrl'] as String,
    plansUrl: json['plansUrl'] as String,
    quizUrl: json['quizUrl'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'feedbackUrl': instance.feedbackUrl,
      'plansUrl': instance.plansUrl,
      'quizUrl': instance.quizUrl,
    };
