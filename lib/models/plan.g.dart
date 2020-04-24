// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map<String, dynamic> json) {
  return Plan(
    json['title'] as String,
    currency: json['currency'] as String,
    description: json['description'] as String,
    price: json['price'] as int,
  );
}

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'currency': instance.currency,
      'description': instance.description,
      'price': instance.price,
      'title': instance.title,
    };
