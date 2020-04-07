//
//  lib/models/plan.dart
//
//  Created by Denis Bystruev on 18/03/2020.
//

class Plan {
  final String currency;
  final String description;
  final int id;
  final int price;
  final String title;

  static int _maxId = 0;
  static int get maxId => _maxId;

  Plan(this.title, {this.currency, this.description, this.price})
      : id = ++_maxId;

  Plan.by(this.title, {this.description, this.price})
      : currency = 'BYN',
        id = ++_maxId;

  Plan.ru(this.title, {this.description, this.price})
      : currency = '₽',
        id = ++_maxId;

  void dispose() => _maxId -= id == _maxId ? 1 : 0;
}
