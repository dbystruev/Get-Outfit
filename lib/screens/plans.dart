//
//  lib/screens/plans.dart
//
//  Created by Denis Bystruev on 18/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/models/plan+all.dart';
import 'package:get_outfit/models/plan.dart';
import 'package:get_outfit/widgets/futura.dart';
import 'package:get_outfit/widgets/plan.dart';

class PlansScreen extends StatelessWidget with Scale {
  final List<Plan> plans =
      AllPlans.local.where((plan) => plan.currency == '₽').toList();

  @override
  Widget build(BuildContext context) {
    print('DEBUG in lib/screens/plans.dart line 20: PlansScreen.build');
    final double scale = getScale(context);
    List<Widget> children = [
      FuturaDemiText.w500(
        'Выберите подходящую услугу',
        fontSize: 20 * scale,
      ),
      SizedBox(height: 10 * scale),
      FuturaBookText.normal(
        'Если вы уже заполняли анкету, можете сразу\n' +
            'оформить услугу. Если нет — стилист вам\n' +
            'направит ссылку на анкету в чате.',
      ),
    ];
    for (final Plan plan in plans)
      children += [
        SizedBox(height: 10 * scale),
        PlanWidget(plan, scale: scale),
      ];
    return Scaffold(
      body: GestureDetector(
        child: SafeArea(
          child: Padding(
            child: Center(
              child: ListView(
                children: children,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30 * scale),
          ),
        ),
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          if (0 < details.delta.dx) Navigator.pop(context);
        },
      ),
    );
  }
}
