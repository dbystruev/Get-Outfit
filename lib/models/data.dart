//
//  lib/models/data.dart
//
//  Created by Denis Bystruev on 23/04/2020.
//

// https://flutter.dev/docs/development/data-and-backend/json
import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';

@JsonSerializable()
class Data {
  String feedbackUrl;
  String plansUrl;
  String quizSheetId;
  String quizUrl;

  Data({this.feedbackUrl, this.plansUrl, this.quizSheetId, this.quizUrl});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
