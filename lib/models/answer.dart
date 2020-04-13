//
//  lib/models/answer.dart
//
//  Created by Denis Bystruev on 12/04/2020.
//

import 'package:flutter/material.dart';

class Answer {
  final List<int> indexes;
  final String text;
  final int value;

  const Answer.defaultIndex()
      : this.indexes = const [0],
        this.text = null,
        this.value = null;

  factory Answer.invertIndex(int index, {List<int> oldIndexes}) =>
      Answer.setIndex(
        index,
        oldIndexes: oldIndexes,
        value: oldIndexes?.contains(index) != true,
      );

  Answer.multi(List<int> indexes)
      : this.indexes = indexes,
        this.text = null,
        this.value = null;

  factory Answer.setIndex(
    int index, {
    @required bool value,
    List<int> oldIndexes,
  }) {
    if (oldIndexes == null) return Answer.multi([if (value) index]);
    Set<int> newSet = oldIndexes.toSet();
    final bool isIndexInSet = newSet.contains(index);
    if (value && !isIndexInSet)
      newSet.add(index);
    else if (!value && isIndexInSet) newSet.remove(index);
    return Answer.multi(
      newSet.toList(),
    );
  }

  Answer.single(int index)
      : this.indexes = [index],
        this.text = null,
        this.value = null;

  Answer.text(String text)
      : this.indexes = null,
        this.text = text,
        this.value = null;

  Answer.value(int value)
      : this.indexes = null,
        this.text = null,
        this.value = value;

  @override
  String toString() => '${indexes ?? ''}${text ?? ''}${value ?? ''}';
}
