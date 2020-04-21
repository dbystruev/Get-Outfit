//
//  lib/screens/login_screen.dart
//
//  Created by Denis Bystruev on 11/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/screens/gender_screen.dart';
import 'package:get_outfit/widgets/button_widget.dart';
// import 'package:get_outfit/widgets/form_widget.dart';
import 'package:get_outfit/widgets/futura_widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Scale {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double scale = getScale(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              FuturaText.bold('GET OUTFIT', fontSize: 28 * scale),
              SizedBox(height: (isHorizontal(context) ? 80 : 240) * scale),
              FuturaDemiText.w500('Добро пожаловать!', fontSize: 20 * scale),
              SizedBox(height: (isHorizontal(context) ? 15 : 45) * scale),
              // FormWidget.login(
              //   controller: emailController,
              //   fontSize: 17 * scale,
              //   labelText: 'Почта',
              //   keyboardType: TextInputType.emailAddress,
              // ),
              // SizedBox(height: 15 * scale),
              // FormWidget.login(
              //   controller: passwordController,
              //   fontSize: 17 * scale,
              //   labelText: 'Пароль',
              //   obscureText: true,
              // ),
              // SizedBox(height: 15 * scale),
              // ButtonWidget(
              //   'Войти',
              //   buttonColor: Theme.of(context).primaryColor,
              //   onPressed: () {
              //     print(
              //         'DEBUG in lib/screens/login.dart line 54: e-mail selected');
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => GenderScreen(),
              //       ),
              //     );
              //   },
              //   scale: scale,
              // ),
              // SizedBox(height: (isHorizontal(context) ? 15 : 45) * scale),
              ButtonWidget(
                'Войти через Google',
                borderColor: Theme.of(context).primaryColor,
                fontSize: 17,
                imageName: 'assets/images/g.png',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenderScreen(),
                    ),
                  );
                },
                scale: scale,
                textColor: Theme.of(context).accentColor,
              ),
              // SizedBox(height: 15 * scale),
              // FlatButton(
              //   onPressed: () {
              //     print(
              //         'DEBUG in lib/screens/login.dart line 85: forgot password');
              //     Navigator.pop(context);
              //   },
              //   child: FuturaMediumText.w500('Забыли пароль?',
              //       color: globals.textColor,
              //       fontSize: 16 * scale),
              // ),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // padding: EdgeInsets.all(19 * scale),
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
          'DEBUG in lib/screens/login.dart line 114 emailController.text = $text');
    });
    passwordController.addListener(() {
      final String text = passwordController.text;
      print(
          'DEBUG in lib/screens/login.dart line 119 passwordController.text = $text');
    });
  }
}
