// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    avatar: json['avatar'] as String,
    email: json['email'] as String,
    id: json['id'] as int,
    name: json['name'] as String,
    phone: json['phone'] as String,
    registrationDate: json['registrationDate'] == null
        ? null
        : DateTime.parse(json['registrationDate'] as String),
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'avatar': instance.avatar,
      'email': instance.email,
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'registrationDate': instance.registrationDate?.toIso8601String(),
      'token': instance.token,
    };
