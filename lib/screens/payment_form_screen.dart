//
//  lib/screens/payment_form_screen.dart
//
//  Created by Denis Bystruev on 24/06/2020.
//

import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';

class PaymentFormScreen extends StatelessWidget {
  static PaymentFormScreen shared = PaymentFormScreen._();

  static const String html = '''
<script src="https://widget.cloudpayments.ru/bundles/cloudpayments"></script>
<script type="text/javascript" language="javascript">
    this.pay = function () {
    var widget = new cp.CloudPayments();
    widget.charge({ // options
            publicId: 'pk_32464a9229095330cabca6e65a5a8',  // id из личного кабинета
            description: 'Пример оплаты (деньги сниматься не будут)', // назначение
            amount: 10, // сумма
            currency: 'RUB', // валюта
            invoiceId: '1234567', //номер заказа (необязательно)
            accountId: 'user@example.com', //идентификатор плательщика (необязательно)
            skin: "mini", //дизайн виджета
            data: {
                myProp: 'myProp value' //произвольный набор параметров
            }
        },
        function (options) { // success
            //действие при успешной оплате
             window.location.assign("/thankyou/");
        },
        function (reason, options) { // fail
            //действие при неуспешной оплате
             window.location.assign("/plans/");
        });
};
pay();
</script>
  ''';
  final String url;
  final Widget webView;

  PaymentFormScreen._([this.url = 'http://getoutfit.ru/cloudpayments'])
      : webView = EasyWebView(
          onLoaded: () {
            debugPrint(
                'DEBUG in lib/screens/payment_form_screen.dart:20 url = $url loaded');
          },
          isHtml: true,
          src: html,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: webView),
    );
  }
}
