// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plans.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plans _$PlansFromJson(Map<String, dynamic> json) {
  return Plans(
    (json['plans'] as List)
        ?.map(
            (e) => e == null ? null : Plan.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    message: json['message'] as String,
    status: json['status'] as String,
    versionDynamic: json['version'],
  );
}

Map<String, dynamic> _$PlansToJson(Plans instance) => <String, dynamic>{
      'message': instance.message,
      'plans': instance.plans?.map((e) => e?.toJson())?.toList(),
      'status': instance.status,
      'version': instance.versionDynamic,
    };
