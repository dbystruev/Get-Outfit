// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerData _$ServerDataFromJson(Map<String, dynamic> json) {
  return ServerData(
    answers: (json['answers'] as List)
        ?.map((e) =>
            e == null ? null : Answer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    order: json['order'] == null
        ? null
        : Order.fromJson(json['order'] as Map<String, dynamic>),
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ServerDataToJson(ServerData instance) =>
    <String, dynamic>{
      'answers': instance.answers?.map((e) => e?.toJson())?.toList(),
      'order': instance.order?.toJson(),
      'user': instance.user?.toJson(),
    };
