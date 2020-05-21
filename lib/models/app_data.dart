//
//  lib/models/app_data.dart
//
//  Created by Denis Bystruev on 23/04/2020.
//

// https://flutter.dev/docs/development/data-and-backend/json
import 'dart:convert' as convert;
import 'package:get_outfit/models/data.dart';
import 'package:get_outfit/models/server_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_data.g.dart';

@JsonSerializable()
class AppData {
  final String data;
  Map<String, dynamic> get _decodedData => convert.jsonDecode(data);
  String get feedbackUrl => Data.fromJson(_decodedData).feedbackUrl;
  final String message;
  String get plansUrl => Data.fromJson(_decodedData).plansUrl;
  String get quizUrl => Data.fromJson(_decodedData).quizUrl;
  final ServerData serverData;
  final String status;
  final int time;
  final String token;
  String get version => versionDynamic.toString();

  @JsonKey(name: 'version')
  final dynamic versionDynamic;

  AppData(
    this.status, {
    this.data,
    this.message,
    this.serverData,
    this.time,
    this.token,
    this.versionDynamic,
  });

  factory AppData.fromJson(Map<String, dynamic> json) =>
      _$AppDataFromJson(json);

  Map<String, dynamic> toJson() => _$AppDataToJson(this);

  String printString(aString) => aString == null ? null : '\'$aString\'';

  @override
  String toString() => '''AppData(
  status: ${printString(status)},
  data: ${printString(data)},
  message: ${printString(message)},
  serverData: $serverData,
  time: $time,
  token: ${printString(token)},
  versionDynamic: ${printString(versionDynamic)},
)''';
}
