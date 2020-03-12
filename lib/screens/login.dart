//
//  login.dart
//
//  Created by Denis Bystruev on 11/03/2020.
//

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_outfit/design/scale.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Scale {
  GlobalKey<State<StatefulWidget>> sizingKey = GlobalKey();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final double height = (sizingKey.currentContext?.findRenderObject() as RenderBox).size.height;
      print('DEBUG in lib/screens/login.dart line 23: height = $height');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double minSpace = 15;
    final double scale = getScale(context, height: 660);
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
                SizedBox(height: (scale < 1 ? minSpace : 132) * scale),
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
                SizedBox(height: (scale < 1 ? minSpace : 45) * scale),
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
                SizedBox(height: (scale < 1 ? minSpace : 15) * scale),
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
                SizedBox(height: (scale < 1 ? minSpace : 45) * scale),
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
                        print('DEBUG in lib/screens/login.dart line 107');
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
                SizedBox(height: (scale < 1 ? minSpace : 45) * scale),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      onPressed: () {
                        print('DEBUG in lib/screens/login.dart line 143');
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
            key: sizingKey,
            padding: EdgeInsets.all(19 * scale),
          ),
        ),
      ),
    );
  }
}
