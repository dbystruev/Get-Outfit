//
//  lib/controllers/network_controllers.dart
//
//  Created by Denis Bystruev on 19/04/2020.
//
//  Derived from https://medium.com/mindorks/storing-data-from-the-flutter-app-google-sheets-e4498e9cda5d
//

import 'dart:convert' as convert;
import 'package:get_outfit/globals.dart' as globals;
import 'package:get_outfit/models/app_data.dart';
import 'package:get_outfit/models/plans.dart';
import 'package:get_outfit/models/questions.dart';
import 'package:http/http.dart' as http;

class NetworkController {
  // Google Apps Script web url
  final String url;

  // Default constructor
  NetworkController({
    this.url = 'https://script.google.com/macros/s/' +
        'AKfycbyVJAPvLhbZtKwJ6-p00NERFQbEK22B4xTdkTL4ReHYYdKMRIV8' +
        '/exec',
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
  Future<String> postQuestions({
    String token,
    String url,
    Questions questions,
  }) async {
    try {
      final String request = '$url?token=$token';
      http.Response response = await http.post(request);
      return response.body;
    } catch (error) {
      return error.toString();
    }
  }
}
