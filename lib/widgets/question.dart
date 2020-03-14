//
//  lib/widgets/question.dart
//
//  Created by Denis Bystruev on 14/03/2020.
//

import 'package:flutter/material.dart';
import 'package:get_outfit/widgets/futura.dart';

class QuestionWidget extends StatelessWidget {
  final double scale;
  final String text;

  QuestionWidget(this.text, {this.scale});

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          FuturaMediumText.w500(text, fontSize: 16 * scale),
        ],
      );
}
