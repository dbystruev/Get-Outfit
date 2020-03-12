//
//  login.dart
//
//  Created by Denis Bystruev on 11/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/widgets/button.dart';
import 'package:get_outfit/widgets/logo.dart';
import 'package:get_outfit/widgets/title.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Scale {
  GlobalKey<State<StatefulWidget>> sizingKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final double minSpace = 15;
    final double scale = getScale(context, height: 660);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final double height =
          (sizingKey.currentContext?.findRenderObject() as RenderBox)
              .size
              .height;
      print('DEBUG in lib/screens/login.dart line 30: height = $height');
    });
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            child: ListView(
              children: <Widget>[
                LogoWidget(fontSize: 32 * scale),
                SizedBox(height: (scale < 1 ? minSpace : 132) * scale),
                TitleWidget('Добро пожаловать!', fontSize: 23 * scale),
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
                ButtonWidget(
                  'Войти',
                  buttonColor: Color(0xFF54615F),
                  onPressed: () {
                    print('DEBUG in lib/screens/login.dart line 81');
                  },
                  scale: scale,
                  textColor: Colors.white,
                ),
                SizedBox(height: (scale < 1 ? minSpace : 45) * scale),
                ButtonWidget(
                  'Войти через Google',
                  borderColor: Color(0xFF54615F),
                  imageName: 'assets/images/g.png',
                  onPressed: () {
                    print('DEBUG in lib/screens/login.dart line 92');
                  },
                  scale: scale,
                  textColor: Color(0xFF54615F),
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
