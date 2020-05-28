//
//  lib/models/server_data.dart
//
//  Created by Denis Bystruev on 3/05/2020.
//
//  https://flutter.dev/docs/development/data-and-backend/json

import 'package:get_outfit/models/answer.dart';
import 'package:get_outfit/models/order.dart';
import 'package:get_outfit/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'server_data.g.dart';

@JsonSerializable(explicitToJson: true)
class ServerData {
  final List<Answer> answers;
  final Order order;
  final User user;

  ServerData({this.answers, this.order, this.user});

  factory ServerData.fromJson(Map<String, dynamic> json) =>
      _$ServerDataFromJson(json);

  Map<String, dynamic> toJson() => _$ServerDataToJson(this);

  @override
  String toString() =>
      'ServerData(answers: $answers, order: $order, user: $user)';
}
