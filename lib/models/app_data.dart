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
  String data;
  String message;
  String status;
  int time;
  String token;
  ServerData serverData;

  @JsonKey(name: 'version')
  dynamic versionDynamic;

  Map<String, dynamic> get _decodedData => convert.jsonDecode(data);
  String get feedbackUrl => Data.fromJson(_decodedData).feedbackUrl;
  String get plansUrl => Data.fromJson(_decodedData).plansUrl;
  String get quizUrl => Data.fromJson(_decodedData).quizUrl;
  String get version => versionDynamic.toString();

  AppData({
    this.data,
    this.message,
    this.serverData,
    this.status,
    this.time,
    this.token,
    this.versionDynamic,
  });

  factory AppData.fromJson(Map<String, dynamic> json) =>
      _$AppDataFromJson(json);

  void merge(AppData appData) {
    if (appData == null) return;
    data = appData.data ?? data;
    message = appData.message ?? message;
    if (serverData == null)
      serverData = appData?.serverData;
    else
      serverData.merge(appData.serverData);
    status = appData.status ?? status;
    time = appData.time ?? time;
    token = appData.token ?? token;
    versionDynamic = appData.versionDynamic ?? versionDynamic;
  }

  Map<String, dynamic> toJson() => _$AppDataToJson(this);

  String printString(aString) => aString == null ? null : '\'$aString\'';

  @override
  String toString() => '''AppData(
  data: ${printString(data)},
  message: ${printString(message)},
  serverData: $serverData,
  status: ${printString(status)},
  time: $time,
  token: ${printString(token)},
  versionDynamic: ${printString(versionDynamic)},
)''';
}
