//
//  lib/controllers/network_controllers.dart
//
//  Created by Denis Bystruev on 19/04/2020.
//
//  Derived from https://medium.com/mindorks/storing-data-from-the-flutter-app-google-sheets-e4498e9cda5d
//

import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:get_outfit/globals.dart' as globals;
import 'package:get_outfit/models/app_data.dart';
import 'package:get_outfit/models/plans.dart';
import 'package:get_outfit/models/question+all.dart';
import 'package:get_outfit/models/question.dart';
import 'package:get_outfit/models/questions.dart';
import 'package:http/http.dart' as http;

class NetworkController {
  static final NetworkController shared = NetworkController._();

  // Google Apps Script web url
  final String authority;
  final String path;
  String get url => 'https://$authority/$path';

  // To be replaced with questions loaded from the server
  List<List<Question>> questions = AllQuestions.local;

  // Default constructor
  NetworkController._({
    this.authority = 'script.google.com',
    this.path =
        'macros/s/AKfycbyVJAPvLhbZtKwJ6-p00NERFQbEK22B4xTdkTL4ReHYYdKMRIV8/exec',
  });

  // Async function which returns feedback and plans urls
  Future<AppData> getAppData({
    String appName = globals.appName,
    String appPassword = globals.appPassword,
  }) async {
    try {
      final String request = '$url?appName=$appName&password=$appPassword';
      http.Response response = await http.get(request);
      final Map<String, dynamic> appDataMap = convert.jsonDecode(response.body);
      return AppData.fromJson(appDataMap);
    } catch (error) {
      return AppData(globals.statusError, message: error.toString());
    }
  }

  // Async function which returns the plans
  Future<Plans> getPlans({
    String token,
    String url,
  }) async {
    try {
      final String request = '$url?token=$token';
      http.Response response = await http.get(request);
      final Map<String, dynamic> plansMap = convert.jsonDecode(response.body);
      return Plans.fromJson(plansMap);
    } catch (error) {
      return Plans([], message: error.toString(), status: globals.statusError);
    }
  }

  // Async function which returns the questions
  Future<Questions> getQuestions(
    String url, {
    String token,
  }) async {
    try {
      final String request = '$url?token=$token';
      http.Response response = await http.get(request);
      final Map<String, dynamic> questionsMap =
          convert.jsonDecode(response.body);
      return Questions.fromJson(questionsMap);
    } catch (error) {
      return Questions([],
          message: error.toString(), status: globals.statusError);
    }
  }

  // Async function which posts the questions
  Future<http.Response> postQuestions(
    Questions questions, {
    String token,
    String url,
  }) async {
    try {
      final String body = convert.json.encode(questions);
      final Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      debugPrint(
        'DEBUG in lib/controllers/network_controller.dart line 89: POST request' +
            '\n  url = $url' +
            '\n  body = $body' +
            '\n  headers = $headers',
      );
      final http.Response response =
          await http.post('$url?token=$token', body: body, headers: headers);
      return response;
    } catch (error) {
      http.Response response = http.Response(error.toString(), 400);
      return response;
    }
  }
}
