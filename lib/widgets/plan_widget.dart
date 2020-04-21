//
//  lib/widgets/plan_widget.dart
//
//  Created by Denis Bystruev on 18/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/globals.dart' as globals;
import 'package:get_outfit/models/plan.dart';
import 'package:get_outfit/screens/payment_screen.dart';
import 'package:get_outfit/widgets/button_widget.dart';
import 'package:get_outfit/widgets/futura_widgets.dart';

class PlanWidget extends StatelessWidget {
  final Plan plan;
  final double scale;

  PlanWidget(this.plan, {this.scale});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FuturaDemiText.w500(plan.title, fontSize: 16 * scale),
              FuturaDemiText.w500(
                '${plan.price} ${plan.currency}',
                fontSize: 16 * scale,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          SizedBox(height: 10 * scale),
          FuturaBookText.normal(
            plan.description,
            fontSize: 12 * scale,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10 * scale),
          ButtonWidget(
            'Оформить услугу',
            buttonColor: Theme.of(context).primaryColor,
            fontSize: 12,
            height: 30,
            mainAxisAlignment: MainAxisAlignment.start,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => PaymentScreen(plan),
                ),
              );
            },
            scale: scale,
            width: 140,
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: globals.textColor,
        ),
        shape: BoxShape.rectangle,
      ),
      padding: EdgeInsets.all(15 * scale),
    );
  }
}
