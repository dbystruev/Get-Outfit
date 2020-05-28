//
//  lib/models/plan.dart
//
//  Created by Denis Bystruev on 18/03/2020.
//

// https://flutter.dev/docs/development/data-and-backend/json
import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

/// This allows the `Plan` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'plan.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Plan {
  static int _maxId = 0;
  static int get maxId => _maxId;

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
      id <= _maxId &&
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
  }) : this.id = id ?? ++_maxId {
    _maxId = max(this.id, _maxId);
  }

  Plan.by(this.title, {this.description, int id, this.price})
      : currency = 'BYN',
        this.id = id ?? ++_maxId {
    _maxId = max(this.id, _maxId);
  }

  Plan.ru(this.title, {this.description, int id, this.price})
      : currency = '₽',
        this.id = id ?? ++_maxId {
    _maxId = max(this.id, _maxId);
  }

  /// A necessary factory constructor for creating a new Plan instance
  /// from a map. Pass the map to the generated `_$PlanFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Plan.
  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$PlanToJson`.
  Map<String, dynamic> toJson() => _$PlanToJson(this);

  void dispose() => _maxId -= id == _maxId ? 1 : 0;

  @override
  String toString() =>
      '\nPlan(' +
      '\'$title\', ' +
      'currency: \'$currency\', ' +
      'description: \'$description\', ' +
      'id: \'$id\', ' +
      'price: \'$price\')';
}
