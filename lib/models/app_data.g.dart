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
    serverData: json['serverData'] == null
        ? null
        : ServerData.fromJson(json['serverData'] as Map<String, dynamic>),
    time: json['time'] as int,
    token: json['token'] as String,
    versionDynamic: json['version'],
  );
}

Map<String, dynamic> _$AppDataToJson(AppData instance) => <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'serverData': instance.serverData,
      'status': instance.status,
      'time': instance.time,
      'token': instance.token,
      'version': instance.versionDynamic,
    };
