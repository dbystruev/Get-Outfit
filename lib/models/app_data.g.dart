// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppData _$AppDataFromJson(Map<String, dynamic> json) {
  return AppData(
    json['status'] as String,
    data: json['data'] as String,
    message: json['message'] as String,
    token: json['token'] as String,
    versionDynamic: json['version'],
  );
}

Map<String, dynamic> _$AppDataToJson(AppData instance) => <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'status': instance.status,
      'token': instance.token,
      'version': instance.versionDynamic,
    };
