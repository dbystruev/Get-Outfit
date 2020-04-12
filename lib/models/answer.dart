//
//  lib/models/answer.dart
//
//  Created by Denis Bystruev on 12/04/2020.
//

class Answer {
  final List<int> indexes;
  final String text;
  final int value;

  const Answer.defaultIndex()
      : this.indexes = const [0],
        this.text = null,
        this.value = null;

  Answer.multi(List<int> indexes)
      : this.indexes = indexes,
        this.text = null,
        this.value = null;

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