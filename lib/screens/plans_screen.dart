//
//  lib/screens/plans_screen.dart
//
//  Created by Denis Bystruev on 18/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/design/scale.dart';
import 'package:get_outfit/models/plan.dart';
import 'package:get_outfit/models/plans.dart';
import 'package:get_outfit/widgets/futura_widgets.dart';
import 'package:get_outfit/widgets/plan_widget.dart';

class PlansScreen extends StatelessWidget with Scale {
  final List<Plan> plans =
      Plans.shared.plans.where((plan) => plan.currency == '₽').toList();

  @override
  Widget build(BuildContext context) {
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
