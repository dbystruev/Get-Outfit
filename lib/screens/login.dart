//
//  login.dart
//
//  Created by Denis Bystruev on 11/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/screens/gender.dart';
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
    print('DEBUG in lib/screens/login.dart line 27: _LoginScreenState.build');
    final double scale = getScale(context, height: 512);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final double height =
          (sizingKey.currentContext?.findRenderObject() as RenderBox)
              .size
              .height;
      print('DEBUG in lib/screens/login.dart line 34: height = $height');
    });
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            child: ListView(
              children: <Widget>[
                LogoWidget(fontSize: 32 * scale),
                SizedBox(
                    height: (isHorizontal(context) && scale < 1 ? 15 : 132) *
                        scale),
                TitleWidget('Добро пожаловать!', fontSize: 23 * scale),
                SizedBox(
                    height:
                        (isHorizontal(context) && scale < 1 ? 15 : 45) * scale),
                FormWidget(
                  controller: emailController,
                  fontSize: 17 * scale,
                  labelText: 'Почта',
                ),
                SizedBox(height: 15 * scale),
                FormWidget(
                  controller: passwordController,
                  fontSize: 17 * scale,
                  labelText: 'Пароль',
                  obscureText: true,
                ),
                SizedBox(height: 15 * scale),
                ButtonWidget(
                  'Войти',
                  buttonColor: Color(0xFF54615F),
                  onPressed: () {
                    print(
                        'DEBUG in lib/screens/login.dart line 62: e-mail selected');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GenderScreen(),
                      ),
                    );
                  },
                  scale: scale,
                  textColor: Colors.white,
                ),
                SizedBox(
                    height:
                        (isHorizontal(context) && scale < 1 ? 15 : 45) * scale),
                ButtonWidget(
                  'Войти через Google',
                  borderColor: Color(0xFF54615F),
                  imageName: 'assets/images/g.png',
                  onPressed: () {
                    print(
                        'DEBUG in lib/screens/login.dart line 79: google selected');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GenderScreen(),
                      ),
                    );
                  },
                  scale: scale,
                  textColor: Color(0xFF54615F),
                ),
                SizedBox(height: 15 * scale),
                FlatButton(
                  onPressed: () {
                    print(
                        'DEBUG in lib/screens/login.dart line 105: forgot password');
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Забыли пароль?',
                    style: TextStyle(
                      color: const Color.fromARGB(102, 0, 0, 0),
                      fontFamily: 'FuturaMediumC',
                      fontSize: 16 * scale,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
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
          'DEBUG in lib/screens/login.dart line 113 emailController.text = $text');
    });
    passwordController.addListener(() {
      final String text = passwordController.text;
      print(
          'DEBUG in lib/screens/login.dart line 118 passwordController.text = $text');
    });
  }
}
