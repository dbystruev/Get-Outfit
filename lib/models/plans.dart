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
  static List<Plan> _plans;
  static Plans _shared;
  static Plans get shared {
    if (_shared == null) _shared = Plans(AllPlans.local);
    return _shared;
  }

  String message;
  String status;
  int time;

  List<Plan> get plans => _plans ?? [];
  set plans(List<Plan> newPlans) {
    if (newPlans != null &&
        newPlans.isNotEmpty &&
        (_plans == null || _plans.isEmpty || _plans.length != newPlans.length))
      _plans = newPlans;
  }

  bool get areValid => plans != null && plans.any((plan) => plan.isValid);
  String get version => versionDynamic.toString();

  @JsonKey(name: 'version')
  dynamic versionDynamic;

  Plans(
    List<Plan> plans, {
    this.message,
    this.status,
    this.time,
    this.versionDynamic,
  }) {
    this.plans = plans;
  }

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
