//
//  login.dart
//
//  Created by Denis Bystruev on 11/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/widgets/button.dart';
import 'package:get_outfit/widgets/form.dart';
import 'package:get_outfit/widgets/logo.dart';
import 'package:get_outfit/widgets/title.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Scale {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<State<StatefulWidget>> sizingKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final double minSpace = 15;
    final double scale = getScale(context, height: 660);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final double height =
          (sizingKey.currentContext?.findRenderObject() as RenderBox)
              .size
              .height;
      print('DEBUG in lib/screens/login.dart line 33: height = $height');
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
                FormWidget(
                  controller: emailController,
                  fontSize: 17 * scale,
                  labelText: 'Почта',
                ),
                SizedBox(height: (scale < 1 ? minSpace : 15) * scale),
                FormWidget(
                  controller: passwordController,
                  fontSize: 17 * scale,
                  labelText: 'Пароль',
                  obscureText: true,
                ),
                SizedBox(height: (scale < 1 ? minSpace : 45) * scale),
                ButtonWidget(
                  'Войти',
                  buttonColor: Color(0xFF54615F),
                  onPressed: () {
                    print('DEBUG in lib/screens/login.dart line 62');
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
                    print('DEBUG in lib/screens/login.dart line 73');
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

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      final String text = emailController.text;
      print(
          'DEBUG in lib/screens/login.dart line 101 emailController.text = $text');
    });
    passwordController.addListener(() {
      final String text = passwordController.text;
      print(
          'DEBUG in lib/screens/login.dart line 106 passwordController.text = $text');
    });
  }
}
