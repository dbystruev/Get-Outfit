//
//  lib/models/plan.dart
//
//  Created by Denis Bystruev on 18/03/2020.
//

class Plan {
  final String currency;
  final String description;
  final int price;
  final String title;

  Plan(this.title, {this.currency, this.description, this.price});

  Plan.by(this.title, {this.description, this.price}) : currency = 'BYN';

  Plan.ru(this.title, {this.description, this.price}) : currency = '₽';
}
