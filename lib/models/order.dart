//
//  lib/models/order.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//

import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()
class Order {
  DateTime creationDate;
  int id;
  bool get isPending => planId != null;
  int planId;

  Order({DateTime creationDate, this.id, this.planId})
      : this.creationDate = creationDate ?? DateTime.now();

  factory Order.merge(Order order, Order newData) => Order(
        creationDate: order?.creationDate ?? newData?.creationDate,
        id: newData?.id ?? order?.id,
        planId: newData?.planId ?? order?.planId,
      );

  factory Order.over(
    Order order, {
    DateTime cleaningDate,
    DateTime creationDate,
    int id,
    double meters,
    int planId,
    String service,
  }) =>
      Order(
        creationDate: creationDate ?? order.creationDate,
        id: id ?? order.id,
        planId: planId ?? order.planId,
      );

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @override
  String toString() {
    return '''Order(
    creationDate: '$creationDate',
    id: $id,
    planId: $planId,
  )''';
  }

  assign({
    DateTime cleaningDate,
    DateTime creationDate,
    int id,
    double meters,
    int planId,
    String service,
  }) {
    this.creationDate = creationDate ?? this.creationDate;
    this.id = id ?? this.id;
    this.planId = planId ?? this.planId;
  }

  clear() {
    creationDate = null;
    id = null;
    planId = null;
  }

  copy(Order order) {
    creationDate = order.creationDate;
    id = order.id;
    planId = order.planId;
  }

  isSimilar(Order order) =>
      creationDate == order.creationDate && planId == order.planId;

  merge(
    Order order,
  ) {
    creationDate = order.creationDate ?? creationDate;
    id = order.id ?? id;
    planId = order.planId ?? planId;
  }
}
