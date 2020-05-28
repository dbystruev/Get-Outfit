//
//  lib/controllers/network_controllers.dart
//
//  Created by Denis Bystruev on 19/04/2020.
//
//  Derived from https://medium.com/mindorks/storing-data-from-the-flutter-app-google-sheets-e4498e9cda5d
//

import 'dart:convert' as convert;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get_outfit/globals.dart' as globals;
import 'package:get_outfit/models/app_data.dart';
import 'package:get_outfit/models/plans.dart';
import 'package:get_outfit/models/prefs_data.dart';
import 'package:get_outfit/models/questions.dart';
import 'package:get_outfit/models/server_data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkController {
  static final NetworkController shared = NetworkController._();

  // Google Apps Script web url
  final String authority;
  final String path;
  String get url => 'https://$authority/$path';

  // Default constructor
  NetworkController._({
    this.authority = 'script.google.com',
    this.path =
        'macros/s/AKfycbyVJAPvLhbZtKwJ6-p00NERFQbEK22B4xTdkTL4ReHYYdKMRIV8/exec',
  });

  // Create new user and save user id in User.shared.id
  Future<void> createNewUser(AppData appData) async {
    // check if no user already created
    if (PrefsData.shared.user?.id != null) return;

    try {
      final String url = appData.feedbackUrl;
      final String generatedCode = '0000';
      final String phone = 'newuser';
      final String token = appData.token;
      final String responseToken = getResponseToken(token);
      final String request = '$url' +
          '?generatedCode=$generatedCode' +
          '&phone=$phone' +
          '&responseToken=$responseToken' +
          '&token=$token';
      final http.Response response = await http.get(request);
      final Map<String, dynamic> appDataMap = convert.jsonDecode(response.body);
      final AppData responseAppData = AppData.fromJson(appDataMap);
      final ServerData serverData = responseAppData?.serverData;
      savePrefsData(
        PrefsData(
          appData: AppData(serverData: serverData),
        ),
      );
    } catch (error) {
      debugPrint(
        'ERROR in lib/controllers/network_controllers.dart:63 error = $error',
      );
    }
  }

  // Async function which returns feedback and plans urls
  Future<AppData> getAppData({
    String appName = globals.appName,
    String appPassword = globals.appPassword,
  }) async {
    try {
      final String request = '$url?appName=$appName&password=$appPassword';
      final http.Response response = await http.get(request);
      final Map<String, dynamic> appDataMap = convert.jsonDecode(response.body);
      return AppData.fromJson(appDataMap);
    } catch (error) {
      return AppData(
        message: error.toString(),
        status: globals.statusError,
      );
    }
  }

  // Calculate SHA-512 digest
  String getHash(String token) {
    final List<int> bytes = convert.utf8.encode(token);
    final Digest digest = sha512.convert(bytes);
    final String hash = digest.toString();
    return hash;
  }

  // Async function which returns the plans
  Future<Plans> getPlans(
    String url, {
    String token,
  }) async {
    try {
      final String request = '$url?token=$token';
      final http.Response response = await http.get(request);
      final Map<String, dynamic> plansMap = convert.jsonDecode(response.body);
      return Plans.fromJson(plansMap);
    } catch (error) {
      return Plans([], message: error.toString(), status: globals.statusError);
    }
  }

  // Get prefs data from shared preferences
  Future<void> getPrefsData() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // get saved prefs data if any
    final String prefsDataString =
        prefs.getString(globals.prefsKeyForPrefsData);

    // return null if no prefs data loaded
    if (prefsDataString == null) return;

    // decode saved prefs data
    final Map<String, dynamic> prefsDataMap =
        convert.jsonDecode(prefsDataString);

    // return null if decode failed
    if (prefsDataMap == null) return;

    // get new prefs data from decoded string
    final PrefsData newPrefsData = PrefsData.fromJson(prefsDataMap);

    // merge loaded and existing prefs data
    PrefsData.shared.merge(newPrefsData);
  }

  // Async function which returns the questions
  Future<Questions> getQuestions(
    String url, {
    String token,
  }) async {
    try {
      final String request = '$url?token=$token';
      final http.Response response = await http.get(request);
      final Map<String, dynamic> questionsMap =
          convert.jsonDecode(response.body);
      return Questions.fromJson(questionsMap);
    } catch (error) {
      return Questions([],
          message: error.toString(), status: globals.statusError);
    }
  }

  // Calculate the response token based on the incoming token
  String getResponseToken(String token) {
    // Calculate the token hash
    final String tokenHash = getHash(token);

    // Split the token hash to array for easier replacement
    final List<String> hash = tokenHash.split('');

    // Calculate the hash length
    final int len = hash.length;

    // Calculate the response token
    hash[0x11111111 % len] = hash[0x22222222 % len];
    hash[0x33333333 % len] = hash[0x44444444 % len];
    hash[0x55555555 % len] = hash[0x66666666 % len];
    hash[0x77777777 % len] = hash[0x88888888 % len];

    // Assemble the hash array back to String
    final String hashString = hash.join();

    // Return the hash of calculated response
    return getHash(hashString);
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
        'DEBUG in lib/controllers/network_controller.dart line 193: POST request' +
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

  // Remove app data shared preferences
  void removePrefsData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(globals.prefsKeyForPrefsData);
  }

  // Save prefs data to shared preferences
  void savePrefsData([PrefsData newPrefsData]) async {
    // merge existing and new prefs data
    PrefsData.shared.merge(newPrefsData);

    // get merged prefs data
    final PrefsData prefsData = PrefsData.shared;

    // don't save null data
    if (prefsData == null || !prefsData.hasData) return;

    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    // convert prefs data to json map
    final Map<String, dynamic> prefsDataMap = prefsData.toJson();

    // convert json map to string
    final String prefsDataString = convert.jsonEncode(prefsDataMap);

    // save prefs data to shared preferenses
    prefs.setString(globals.prefsKeyForPrefsData, prefsDataString);
  }
}
