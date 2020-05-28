//
//  lib/globals.dart
//
//  Created by Denis Bystruev on 15/04/2020.
//

library cleaning.globals;

import 'package:flutter/material.dart';

// The foreground color for widgets (knobs, text, overscroll edge effect, etc).
const Color accentColor = Color(0xFF54615F);

// App credentials to get plans and feedback sheet ids
const String appName = 'getoutfit';
const String appPassword = 'toh0ung2ohY8Uyev';
const String appVersion = '2020.04.21.13:45:00';

// True if running in release mode
const bool isProduction = bool.fromEnvironment('dart.vm.product');

// The background color for major parts of the app (toolbars, tab bars, etc)
const Color primaryColor = Color(0xFF54615F);

// Similar to toString() for iterables, but values are quoted
Iterable<String> quotedValues<T>(Iterable<T> values) =>
    values.map((value) => '\'$value\'');

// Preferences key for saving/loading server data locally
const String serverDataPrefsKey = 'app.getoutfit.quiz.serverData';

// Success and error codes for external requests
const statusError = 'ERROR';
const statusSuccess = 'SUCCESS';

// Default text color
const Color textColor = const Color.fromARGB(102, 0, 0, 0);
