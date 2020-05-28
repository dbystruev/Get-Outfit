// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prefs_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrefsData _$PrefsDataFromJson(Map<String, dynamic> json) {
  return PrefsData(
    appData: json['appData'] == null
        ? null
        : AppData.fromJson(json['appData'] as Map<String, dynamic>),
    plans: json['plans'] == null
        ? null
        : Plans.fromJson(json['plans'] as Map<String, dynamic>),
    questions: json['questions'] == null
        ? null
        : Questions.fromJson(json['questions'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PrefsDataToJson(PrefsData instance) => <String, dynamic>{
      'appData': instance.appData?.toJson(),
      'plans': instance.plans?.toJson(),
      'questions': instance.questions?.toJson(),
    };
