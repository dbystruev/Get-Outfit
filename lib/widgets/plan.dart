//
//  lib/widgets/plan.dart
//
//  Created by Denis Bystruev on 18/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/models/plan.dart';
import 'package:get_outfit/widgets/button.dart';
import 'package:get_outfit/widgets/futura.dart';

class PlanWidget extends StatelessWidget {
  final Plan plan;
  final double scale;

  PlanWidget(this.plan, {this.scale});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
            buttonColor: Color(0xFF54615F),
            fontSize: 12,
            height: 30,
            mainAxisAlignment: MainAxisAlignment.start,
            onPressed: () {
              print(
                  'DEBUG in lib/widgets/plan.dart line 46: ${plan.title} pressed');
            },
            scale: scale,
            width: 120,
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(102, 0, 0, 0),
        ),
        shape: BoxShape.rectangle,
      ),
      padding: EdgeInsets.all(15 * scale),
    );
  }
}
