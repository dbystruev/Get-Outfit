// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppData _$AppDataFromJson(Map<String, dynamic> json) {
  return AppData(
    data: json['data'] as String,
    message: json['message'] as String,
    serverData: json['serverData'] == null
        ? null
        : ServerData.fromJson(json['serverData'] as Map<String, dynamic>),
    status: json['status'] as String,
    time: json['time'] as int,
    token: json['token'] as String,
    versionDynamic: json['version'],
  );
}

Map<String, dynamic> _$AppDataToJson(AppData instance) => <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'status': instance.status,
      'time': instance.time,
      'token': instance.token,
      'serverData': instance.serverData,
      'version': instance.versionDynamic,
    };
