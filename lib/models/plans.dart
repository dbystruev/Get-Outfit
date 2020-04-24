//
//  lib/models/plans.dart
//
//  Created by Denis Bystruev on 23/04/2020.
//

// https://flutter.dev/docs/development/data-and-backend/json
import 'package:get_outfit/models/plan.dart';
import 'package:json_annotation/json_annotation.dart';
part 'plans.g.dart';

@JsonSerializable(explicitToJson: true)
class Plans {
  bool get isValid => plans.any((plan) => plan.isValid);
  final String message;
  List<Plan> plans;
  final String status;
  String get version => versionDynamic.toString();

  @JsonKey(name: 'version')
  final dynamic versionDynamic;

  Plans(this.plans, {this.message, this.status, this.versionDynamic});

  factory Plans.fromJson(Map<String, dynamic> json) => _$PlansFromJson(json);

  Map<String, dynamic> toJson() => _$PlansToJson(this);
}