part of 'models.dart';

class Food {
  late String name;

  Food({required this.name});

  factory Food.createFood(Map<String, dynamic> object) {
    return Food(name: object['name']);
  }
}
