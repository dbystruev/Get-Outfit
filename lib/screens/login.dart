//
//  lib/screens/login.dart
//
//  Created by Denis Bystruev on 11/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/screens/gender.dart';
import 'package:get_outfit/widgets/button.dart';
import 'package:get_outfit/widgets/form.dart';
import 'package:get_outfit/widgets/futura.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Scale {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('DEBUG in lib/screens/login.dart line 25: _LoginScreenState.build');
    final double scale = getScale(context, height: 680);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: <Widget>[
              FuturaText.bold('GET OUTFIT', fontSize: 28 * scale),
              SizedBox(
                  height:
                      (isHorizontal(context) && scale < 1 ? 15 : 132) * scale),
              FuturaDemiText.w500('Добро пожаловать!', fontSize: 20 * scale),
              SizedBox(
                  height:
                      (isHorizontal(context) && scale < 1 ? 15 : 45) * scale),
              FormWidget(
                controller: emailController,
                fontSize: 17 * scale,
                labelText: 'Почта',
                keyboardType: TextInputType.emailAddress,
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
                      'DEBUG in lib/screens/login.dart line 59: e-mail selected');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenderScreen(),
                    ),
                  );
                },
                scale: scale,
              ),
              SizedBox(
                  height:
                      (isHorizontal(context) && scale < 1 ? 15 : 45) * scale),
              ButtonWidget(
                'Войти через Google',
                borderColor: Color(0xFF54615F),
                fontSize: 18,
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
                      'DEBUG in lib/screens/login.dart line 94: forgot password');
                  Navigator.pop(context);
                },
                child: FuturaMediumText.w500('Забыли пароль?',
                    color: const Color.fromARGB(102, 0, 0, 0),
                    fontSize: 16 * scale),
              )
            ],
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
          'DEBUG in lib/screens/login.dart line 122 emailController.text = $text');
    });
    passwordController.addListener(() {
      final String text = passwordController.text;
      print(
          'DEBUG in lib/screens/login.dart line 127 passwordController.text = $text');
    });
  }
}
