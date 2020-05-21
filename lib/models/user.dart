//
//  lib/models/user.dart
//
//  Created by Denis Bystruev on 1/05/2020.
//
//  https://flutter.dev/docs/development/data-and-backend/json

import 'package:get_outfit/models/server_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  static final User shared = User();

  String avatar;
  String email;
  int id;
  bool get isFilled => email != null && name != null && phone != null;
  bool get isLoggedIn => token != null && token.length == 128;
  String name;
  String phone;
  DateTime registrationDate;
  String token;

  User({
    this.avatar,
    this.email,
    this.id,
    this.name,
    this.phone,
    DateTime registrationDate,
    this.token,
  }) : this.registrationDate = registrationDate ?? DateTime.now();

  factory User.merge(User user, User newData) => User(
        avatar: newData?.avatar ?? user?.avatar,
        email: newData?.email ?? user?.email,
        id: newData?.id ?? user?.id,
        name: newData?.name ?? user?.name,
        phone: newData?.phone ?? user?.phone,
        registrationDate: user?.registrationDate ?? newData?.registrationDate,
        token: newData?.token ?? user?.token,
      );

  factory User.over(
    User user, {
    String avatar,
    String email,
    int id,
    String name,
    String phone,
    DateTime registrationDate,
    String token,
  }) =>
      User(
        avatar: avatar ?? user.avatar,
        email: email ?? user.email,
        id: id ?? user.id,
        name: name ?? user.name,
        phone: phone ?? user.phone,
        registrationDate: registrationDate ?? user.registrationDate,
        token: token ?? user.token,
      );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return '''User(
    avatar: '$avatar',
    email: '$email',
    id: $id,
    name: '$name',
    phone: '$phone',
    registrationDate: '$registrationDate',
    token: '$token',
  )''';
  }

  void assign({
    String avatar,
    String email,
    int id,
    String name,
    String phone,
    DateTime registrationDate,
    String token,
  }) {
    this.avatar = avatar ?? this.avatar;
    this.email = email ?? this.email;
    this.id = id ?? this.id;
    this.name = name ?? this.name;
    this.phone = phone ?? this.phone;
    this.registrationDate = registrationDate ?? this.registrationDate;
    this.token = token ?? this.token;
  }

  void clear() {
    avatar = null;
    email = null;
    id = null;
    name = null;
    phone = null;
    registrationDate = null;
    token = null;
  }

  void merge(User user) {
    avatar = user?.avatar ?? avatar;
    email = user?.email ?? email;
    id = user?.id ?? id;
    name = user?.name ?? name;
    phone = user?.phone ?? phone;
    registrationDate = user?.registrationDate ?? registrationDate;
    token = user?.token ?? token;
  }
}
