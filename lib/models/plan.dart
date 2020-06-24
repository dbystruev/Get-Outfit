//
//  lib/models/plan.dart
//
//  Created by Denis Bystruev on 18/03/2020.
//

// https://flutter.dev/docs/development/data-and-backend/json
import 'package:json_annotation/json_annotation.dart';

/// This allows the `Plan` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'plan.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Plan {
  static List<Plan> _allPlans;
  static int get length => _allPlans?.length ?? 0;
  static int get maxId => length < 1 ? null : length - 1;

  // Return plan id if this plan is already present or null if not
  static int findPlanId({
    String currency,
    String description,
    int price,
    String title,
  }) =>
      _allPlans
          ?.firstWhere(
              (plan) =>
                  plan.currency == currency &&
                  plan.price == price &&
                  plan.description == description &&
                  plan.title == title,
              orElse: () => null)
          ?.id;

  final String currency;
  final String description;
  final int id;
  final int price;
  final String title;

  bool get isValid =>
      currency != null &&
      currency.isNotEmpty &&
      description != null &&
      description.isNotEmpty &&
      id != null &&
      0 < id &&
      id <= length &&
      price != null &&
      0 < price &&
      title != null &&
      title.isNotEmpty;

  Plan(
    this.title, {
    this.currency,
    this.description,
    int id,
    this.price,
  }) : this.id = id ??
            findPlanId(
              currency: currency,
              description: description,
              price: price,
              title: title,
            ) ??
            length {
    if (length == this.id) {
      if (_allPlans == null)
        _allPlans = [this];
      else
        _allPlans.add(this);
    }
  }

  factory Plan.by(String title, {String description, int id, int price}) =>
      Plan(
        title,
        currency: 'BYN',
        description: description,
        id: id,
        price: price,
      );

  factory Plan.ru(String title, {String description, int id, int price}) =>
      Plan(
        title,
        currency: '₽',
        description: description,
        id: id,
        price: price,
      );

  /// A necessary factory constructor for creating a new Plan instance
  /// from a map. Pass the map to the generated `_$PlanFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Plan.
  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$PlanToJson`.
  Map<String, dynamic> toJson() => _$PlanToJson(this);

  void dispose() {
    _allPlans?.clear();
    _allPlans = null;
  }

  @override
  String toString() =>
      '\nPlan(' +
      '\'$title\', ' +
      'currency: \'$currency\', ' +
      'description: \'$description\', ' +
      'id: \'$id\', ' +
      'price: \'$price\')';
}
