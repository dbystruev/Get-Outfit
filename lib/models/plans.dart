//
//  lib/models/plans.dart
//
//  Created by Denis Bystruev on 23/04/2020.
//

// https://flutter.dev/docs/development/data-and-backend/json
import 'package:get_outfit/models/plan+all.dart';
import 'package:get_outfit/models/plan.dart';
import 'package:json_annotation/json_annotation.dart';
part 'plans.g.dart';

@JsonSerializable(explicitToJson: true)
class Plans {
  static final Plans shared = Plans(AllPlans.local);

  String message;
  List<Plan> plans;
  String status;
  int time;

  bool get areValid => plans != null && plans.any((plan) => plan.isValid);
  String get version => versionDynamic.toString();

  @JsonKey(name: 'version')
  dynamic versionDynamic;

  Plans(
    this.plans, {
    this.message,
    this.status,
    this.time,
    this.versionDynamic,
  });

  factory Plans.fromJson(Map<String, dynamic> json) => _$PlansFromJson(json);

  void merge(Plans newPlans) {
    message = newPlans?.message ?? message;
    plans = newPlans?.plans ?? plans;
    status = newPlans?.status ?? status;
    time = newPlans?.time ?? time;
    versionDynamic = newPlans?.versionDynamic ?? versionDynamic;
  }

  Map<String, dynamic> toJson() => _$PlansToJson(this);

  @override
  String toString() =>
      '\n${plans.length} Plans(' +
      'message: \'$message\', ' +
      'status: \'$status\', ' +
      'time: \'$time\', ' +
      'versionDynamic: \'$version\')';
}
