//
//  login.dart
//
//  Created by Denis Bystruev on 11/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Scale {
  @override
  Widget build(BuildContext context) {
    final double scale = getScale(context, height: 524);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            child: ListView(
              children: <Widget>[
                Text(
                  'GET OUTFIT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Futura',
                    fontSize: 32 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 132 * scale),
                Text(
                  'Добро пожаловать!',
                  style: TextStyle(
                    color: const Color(0xFF54615F),
                    fontFamily: 'FuturaMediumC',
                    fontSize: 23 * scale,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 45 * scale),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Color.fromARGB(26, 84, 97, 95),
                    filled: true,
                    labelText: 'Почта',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    fontFamily: 'FuturaMediumC',
                    fontSize: 17 * scale,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15 * scale),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Color.fromARGB(26, 84, 97, 95),
                    filled: true,
                    labelText: 'Пароль',
                  ),
                  style: TextStyle(
                    fontFamily: 'FuturaMediumC',
                    fontSize: 17 * scale,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 45 * scale),
                ButtonTheme(
                  child: Padding(
                    child: FlatButton(
                      color: Color(0xFF54615F),
                      child: Text(
                        'Войти',
                        style: TextStyle(
                          fontFamily: 'FuturaMediumC',
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        print('DEBUG in lib/screens/login.dart line 94');
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9 * scale),
                      ),
                      textColor: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 54 * scale),
                  ),
                  height: 50 * scale,
                  minWidth: 228 * scale,
                ),
                SizedBox(height: 45 * scale),
                ButtonTheme(
                  child: Padding(
                    child: FlatButton(
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/g.png',
                            height: 18 * scale,
                            width: 18 * scale,
                          ),
                          SizedBox(width: 8 * scale),
                          Text(
                            'Войти через Google',
                            style: TextStyle(
                              fontFamily: 'FuturaMediumC',
                              fontSize: 16 * scale,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        print('DEBUG in lib/screens/login.dart line 115');
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9 * scale),
                        side: BorderSide(
                          color: Color(0xFF54615F),
                          width: 2 * scale,
                        ),
                      ),
                      textColor: Color(0xFF54615F),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 54 * scale),
                  ),
                  height: 50 * scale,
                  minWidth: 228 * scale,
                ),
              ],
            ),
            padding: EdgeInsets.all(19 * scale),
          ),
        ),
      ),
    );
  }
}
