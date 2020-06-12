//
//  lib/models/answer.dart
//
//  Created by Denis Bystruev on 12/04/2020.
//

// https://flutter.dev/docs/development/data-and-backend/json
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'answer.g.dart';

@JsonSerializable()
class Answer {
  final List<int> indexes;
  final String text;
  final int value;

  Answer({this.indexes, this.text, this.value});

  const Answer.defaultIndex()
      : this.indexes = const [0],
        this.text = null,
        this.value = null;

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  factory Answer.fromString(String answerString) {
    if (answerString == null) return Answer.defaultIndex();
    final int value = int.tryParse(answerString);
    if (value != null) return Answer(value: value);
    if (answerString.startsWith('[') && answerString.endsWith(']')) {
      final String stringValues =
          answerString.substring(1, answerString.length - 1);
      if (stringValues.isEmpty) return Answer(indexes: []);
      final List<String> stringIndexes = stringValues.split(', ');
      final List<int> indexes = stringIndexes
          .map((stringValue) => int.tryParse(stringValue))
          .toList();
      if (indexes.every((index) => index != null))
        return Answer(indexes: indexes);
    }
    return Answer(text: answerString);
  }

  factory Answer.invertIndex(int index, {List<int> oldIndexes}) =>
      Answer.setIndex(
        index,
        oldIndexes: oldIndexes,
        value: oldIndexes?.contains(index) != true,
      );

  Answer.multiIndexes(List<int> indexes)
      : this.indexes = indexes,
        this.text = null,
        this.value = null;

  factory Answer.setIndex(
    int index, {
    @required bool value,
    List<int> oldIndexes,
  }) {
    if (oldIndexes == null) return Answer.multiIndexes([if (value) index]);
    Set<int> newSet = oldIndexes.toSet();
    final bool isIndexInSet = newSet.contains(index);
    if (value && !isIndexInSet)
      newSet.add(index);
    else if (!value && isIndexInSet) newSet.remove(index);
    return Answer.multiIndexes(
      newSet.toList(),
    );
  }

  Answer.singleIndex(int index)
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

  Map<String, dynamic> toJson() => _$AnswerToJson(this);

  @override
  bool operator ==(dynamic other) {
    if (other == null ||
        !(other is Answer) ||
        indexes?.length != other.indexes?.length) return false;
    if (indexes != null)
      for (int index = 0; index < indexes.length; index++)
        if (indexes[index] != other.indexes[index]) return false;
    return text == other.text && value == other.value;
  }

  @override
  String toString() {
    if (text != null) return text;
    if (value != null) return value.toString();
    return indexes?.toString();
  }
}
