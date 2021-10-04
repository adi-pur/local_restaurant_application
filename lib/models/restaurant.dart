part of 'models.dart';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  String? address;
  late double rating;
  List<String>? categories;
  List<Food>? foods;
  List<Drink>? drinks;
  List<dynamic>? customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    this.address,
    required this.rating,
    this.categories,
    this.foods,
    this.drinks,
    this.customerReviews,
  });

  factory Restaurant.createRestaurant(Map<String, dynamic> object,
          {List<String>? categories,
          List<Food>? foods,
          List<Drink>? drinks,
          List<CustomerReviews>? customerReviews}) =>
      Restaurant(
        id: object['id'],
        name: object['name'],
        description: object['description'],
        pictureId: object['pictureId'],
        city: object['city'],
        address: object['address'],
        rating: object['rating'].toDouble(),
        categories: categories,
        foods: foods,
        drinks: drinks,
        customerReviews: customerReviews,
      );

  static List<Restaurant> getRestaurants(String? jsonResult) {
    if (jsonResult == null) {
      return [];
    }

    var jsonObject = jsonDecode(jsonResult);
    List<dynamic> listRestaurants =
        (jsonObject as Map<String, dynamic>)['restaurants'];

    List<Restaurant> restaurants = [];

    for (int i = 0; i < listRestaurants.length; i++) {
      List<dynamic> listFoods =
          (listRestaurants[i]['menus'] as Map<String, dynamic>)['foods'];
      List<dynamic> listDrinks =
          (listRestaurants[i]['menus'] as Map<String, dynamic>)['drinks'];

      List<Food> foods = [];
      List<Drink> drinks = [];

      for (int i = 0; i < listFoods.length; i++)
        foods.add(Food.createFood(listFoods[i]));
      for (int i = 0; i < listDrinks.length; i++)
        drinks.add(Drink.createDrink(listDrinks[i]));

      restaurants.add(Restaurant.createRestaurant(listRestaurants[i],
          foods: foods, drinks: drinks));
    }
    return restaurants;
  }
}
