// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    creationDate: json['creationDate'] == null
        ? null
        : DateTime.parse(json['creationDate'] as String),
    id: json['id'] as int,
    planId: json['planId'] as int,
    promoCode: json['promoCode'] as String,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'creationDate': instance.creationDate?.toIso8601String(),
      'id': instance.id,
      'planId': instance.planId,
      'promoCode': instance.promoCode,
    };
