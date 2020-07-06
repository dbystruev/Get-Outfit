//
//  lib/screens/payment_screen.dart
//
//  Created by Denis Bystruev on 02/04/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/controllers/network_controller.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/globals.dart' as globals;
import 'package:get_outfit/models/answer.dart';
import 'package:get_outfit/models/app_data.dart';
import 'package:get_outfit/models/order.dart';
import 'package:get_outfit/models/plan.dart';
import 'package:get_outfit/models/prefs_data.dart';
import 'package:get_outfit/models/question.dart';
import 'package:get_outfit/models/question_type.dart';
import 'package:get_outfit/models/server_data.dart';
import 'package:get_outfit/models/user.dart';
import 'package:get_outfit/widgets/button_widget.dart';
import 'package:get_outfit/widgets/futura_widgets.dart';
import 'package:get_outfit/widgets/question_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentScreen extends StatefulWidget {
  final Plan plan;

  PaymentScreen(this.plan);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> with Scale {
  final TextEditingController controllerForEmail = TextEditingController();
  final TextEditingController controllerForName = TextEditingController();
  final TextEditingController controllerForPhone = TextEditingController();
  final TextEditingController controllerForPromocode = TextEditingController();

  bool get isValidInput => validateInputData().isEmpty;
  Plan get plan => widget.plan;

  @override
  Widget build(BuildContext context) {
    final String priceString = '${plan.price} ${plan.currency}';
    final List<Question> questions = [
      Question(
        'Имя',
        controller: controllerForName,
        type: QuestionType.inlineText,
      ),
      Question(
        'E-mail',
        controller: controllerForEmail,
        keyboardType: TextInputType.emailAddress,
        type: QuestionType.inlineText,
      ),
      Question(
        'Мобильный телефон',
        controller: controllerForPhone,
        keyboardType: TextInputType.phone,
        type: QuestionType.inlineText,
      ),
      Question(
        'Промокод',
        controller: controllerForPromocode,
        type: QuestionType.inlineText,
      ),
    ];
    int index = 0;
    final double scale = getScale(context);
    final List<Widget> questionWidgets = questions
        .map(
          (question) => QuestionWidget(
            index++,
            question,
            onAnswer: (Answer answer, {String label}) => setState(() {}),
            scale: scale,
          ),
        )
        .toList();
    final List<Widget> children = [
          FuturaDemiText.w600(
            'Оформите услугу:',
            fontSize: 20 * scale,
          ),
          SizedBox(height: 20 * scale),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FuturaMediumText.w500(
                    'Услуга ${plan.title}',
                    fontSize: 14 * scale,
                    textAlign: TextAlign.start,
                  ),
                ),
                FuturaBookText.normal(
                  priceString,
                  color: Colors.black,
                  fontSize: 13 * scale,
                ),
                SizedBox(width: 25 * scale),
                GestureDetector(
                  child: Icon(
                    Icons.highlight_off,
                    color: Color(0xFFC4C4C4),
                    size: 16 * scale,
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(
                  color: Color(0xFFC4C4C4),
                  width: scale,
                ),
              ),
            ),
            padding: EdgeInsets.fromLTRB(0, 12 * scale, 0, 10 * scale),
          ),
          SizedBox(height: 11 * scale),
          Row(
            children: <Widget>[
              Expanded(
                child: FuturaMediumText.w500(
                  'Сумма: $priceString',
                  color: Colors.black,
                  fontSize: 14 * scale,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          SizedBox(height: 40 * scale),
          FuturaBookText.normal(
            'После оплаты сервиса с вами свяжется стилист.',
            fontSize: 16 * scale,
          ),
          SizedBox(height: 20 * scale),
        ] +
        questionWidgets +
        [
          SizedBox(height: 15 * scale),
          ButtonWidget(
            'Оплатить услугу',
            buttonColor: Theme.of(context).primaryColor,
            fontSize: 12,
            height: 30,
            onPressed: isValidInput
                ? () {
                    launchPaymentURL();
                    sendNewOrder();
                  }
                : null,
            scale: scale,
            width: 140,
          ),
          SizedBox(height: 20 * scale),
          FuturaBookText.normal(
            'Нажимая на кнопку, вы даете согласие на получение писем, обработку персональных данных и соглашаетесь с политикой конфиденциальности.',
            fontSize: 12 * scale,
          ),
        ];
    return Scaffold(
      body: GestureDetector(
        child: SafeArea(
          child: Center(
            child: Padding(
              child: ListView(children: children),
              padding: EdgeInsets.symmetric(horizontal: 30 * scale),
            ),
          ),
        ),
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          if (0 < details.delta.dx) Navigator.pop(context);
        },
        onTap: hideKeyboard,
      ),
    );
  }

  // Hide keyboard
  void hideKeyboard() => FocusScope.of(context).unfocus();

  @override
  void initState() {
    super.initState();
    controllerForEmail.text = PrefsData.shared.user?.email;
    controllerForName.text = PrefsData.shared.user?.name;
    controllerForPhone.text = globals.digits(PrefsData.shared.user?.phone);
    controllerForPromocode.text = PrefsData.shared.order?.promoCode;
  }

  void launchPaymentURL() {
    final String url = '${globals.paymentUrl}' +
        '?accountId=' +
        Uri.encodeQueryComponent(PrefsData.shared.user.email) +
        '&amount=' +
        Uri.encodeQueryComponent('${plan.price}') +
        '&currency=' +
        Uri.encodeQueryComponent('RUB') +
        '&escription=' +
        Uri.encodeQueryComponent(plan.title) +
        '&invoiceId=' +
        Uri.encodeQueryComponent('${PrefsData.shared.user.id}') +
        '&phone=' +
        Uri.encodeQueryComponent(PrefsData.shared.user.phone);
    launchURL(url);
  }

  void launchURL(String url) async {
    debugPrint(
      'DEBUG in lib/screens/payment_screen.dart:216 launchURL($url)',
    );
    if (await canLaunch(url)) {
      await launch(url);
    } else
      debugPrint(
        'ERROR in lib/screens/payment_screen.dart:222 launchURL($url)',
      );
  }

  // Get all enterd data and save it to prefs and the server
  void sendNewOrder() async {
    PrefsData.shared.user.merge(
      User(
        email: controllerForEmail.text,
        name: controllerForName.text,
        phone: controllerForPhone.text,
      ),
    );
    await NetworkController.shared.savePrefsData(
      PrefsData(
        appData: AppData(
          serverData: ServerData(
            order:
                Order(planId: plan.id, promoCode: controllerForPromocode.text),
          ),
        ),
      ),
    );
    final AppData appData =
        await NetworkController.shared.postOrder().catchError(
              (error) => debugPrint(
                'ERROR in lib/screens/payment_screen.dart:248 sendNewOrder() ' +
                    error.toString(),
              ),
            );
    await NetworkController.shared.savePrefsData(
      PrefsData(appData: appData),
    );
  }

  // Validate input data, return '' if everything is OK
  String validateInputData() {
    if (controllerForEmail.text.isEmpty) return 'E-mail should not be empty';
    if (controllerForName.text.isEmpty) return 'The name should not be empty';
    if (controllerForPhone.text.isEmpty) return 'The phone should not be empty';
    return '';
  }
}
