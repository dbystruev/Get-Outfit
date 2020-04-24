//
//  lib/screens/payment_screen.dart
//
//  Created by Denis Bystruev on 02/04/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/models/answer.dart';
import 'package:get_outfit/models/plan.dart';
import 'package:get_outfit/models/question.dart';
import 'package:get_outfit/screens/thank_you_screen.dart';
import 'package:get_outfit/widgets/button_widget.dart';
import 'package:get_outfit/widgets/futura_widgets.dart';
import 'package:get_outfit/widgets/question_widget.dart';

class PaymentScreen extends StatelessWidget with Scale {
  final Plan plan;

  PaymentScreen(this.plan);

  @override
  Widget build(BuildContext context) {
    final String priceString = '${plan.price} ${plan.currency}';
    final List<Question> questions = [
      Question('Имя', type: QuestionType.inlineText),
      Question('E-mail', type: QuestionType.inlineText),
      Question('Мобильный телефон', type: QuestionType.inlineText),
      Question('Промокод', type: QuestionType.inlineText),
    ];
    int index = 0;
    final double scale = getScale(context);
    final List<Widget> questionWidgets = questions
        .map((question) => QuestionWidget(
              index++,
              question,
              onAnswer: (Answer answer, {String label}) => debugPrint(
                  'DEBUG in lib/screens/payment_screen.dart line 38: answer = $answer'),
              scale: scale,
            ))
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ThankYouScreen(),
                ),
              );
            },
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
      ),
    );
  }
}
