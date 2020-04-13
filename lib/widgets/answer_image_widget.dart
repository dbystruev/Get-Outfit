//
//  lib/widgets/answer_image_widget.dart
//
//  Created by Denis Bystruev on 13/04/2020.
//

import 'package:flutter/material.dart';

class AnswerImageWidget extends StatelessWidget {
  const AnswerImageWidget(
    this.url, {
    @required this.index,
    @required this.onSelected,
    @required this.scale,
    @required this.selected,
  });

  final int index;
  final Function(int) onSelected;
  final double scale;
  final bool selected;
  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          Image.network(
            url,
            fit: BoxFit.fitHeight,
          ),
          if (selected)
            Positioned(
              child: Icon(Icons.check_circle,
                  color: Colors.black, size: 20 * scale),
              left: -5 * scale,
              top: -10 * scale,
            ),
        ],
        overflow: Overflow.visible,
      ),
      onTap: () => onSelected(index),
    );
  }
}
