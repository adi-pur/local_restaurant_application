part of 'models.dart';

class Drink {
  late String name;

  Drink({required this.name});

  factory Drink.createDrink(Map<String, dynamic> object) {
    return Drink(name: object['name']);
  }
}
