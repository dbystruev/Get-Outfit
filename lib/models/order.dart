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
  int planId;
  String promoCode;

  bool get isPending => planId != null;

  Order({DateTime creationDate, this.id, this.planId, this.promoCode})
      : this.creationDate = creationDate ?? DateTime.now();

  factory Order.merge(Order order, Order newData) => Order(
        creationDate: order?.creationDate ?? newData?.creationDate,
        id: newData?.id ?? order?.id,
        planId: newData?.planId ?? order?.planId,
        promoCode: newData?.promoCode ?? order?.promoCode,
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

  void assign({
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

  void clear() {
    creationDate = null;
    id = null;
    planId = null;
  }

  void copy(Order order) {
    creationDate = order.creationDate;
    id = order.id;
    planId = order.planId;
  }

  bool isSimilar(Order order) =>
      creationDate == order.creationDate && planId == order.planId;

  void merge(Order order) {
    if (order == null) return;
    creationDate = order.creationDate ?? creationDate;
    id = order.id ??
        (order.creationDate == null || order.planId == null ? id : null);
    planId = order.planId ?? planId;
    promoCode = order.promoCode ?? promoCode;
  }
}
