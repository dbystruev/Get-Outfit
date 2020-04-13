//
//  lib/widgets/checkbox_widget.dart
//
//  Created by Denis Bystruev on 13/04/2020.
//

import 'package:flutter/material.dart';

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({
    @required this.index,
    this.label,
    @required this.onSelected,
    @required this.scale,
    @required this.selected,
  });

  final int index;
  final Widget label;
  final Function(int, bool) onSelected;
  final double scale;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Row(
          children: <Widget>[
            Checkbox(
              activeColor: Color(0xFF54615F),
              checkColor: Colors.white,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (value) => onSelected(index, value),
              value: selected,
              visualDensity: VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
            ),
            if (label != null) Flexible(child: label),
          ],
        ),
        onTap: () => onSelected(index, !selected),
      ),
    );
  }
}
