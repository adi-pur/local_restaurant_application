part of 'services.dart';

class RestaurantService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev';

  static Future<List<Restaurant>> getRestaurants() async {
    Uri apiURI = Uri.parse(_baseUrl + '/list');
    var apiResult = await http.get(apiURI);

    if (apiResult.statusCode == 200) {
      var jsonObject = json.decode(apiResult.body);
      var listRestaurants = (jsonObject as Map<String, dynamic>)['restaurants'];

      List<Restaurant> restaurants = List<Restaurant>.from(
          listRestaurants.map((x) => Restaurant.createRestaurant(x)));

      return restaurants;
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  static Future<Restaurant> getRestaurantDetail(String id) async {
    Uri apiURI = Uri.parse(_baseUrl + '/detail/' + id);
    var apiResult = await http.get(apiURI);

    if (apiResult.statusCode == 200) {
      var jsonObject = json.decode(apiResult.body);
      var restaurantData = (jsonObject as Map<String, dynamic>)['restaurant'];

      List<String> categories = List<String>.from(restaurantData["categories"]
          .map((x) => (x as Map<String, dynamic>)['name']));
      List<Food> foods = List<Food>.from(
          (restaurantData['menus'] as Map<String, dynamic>)['foods']
              .map((x) => Food.createFood(x)));
      List<Drink> drinks = List<Drink>.from(
          (restaurantData['menus'] as Map<String, dynamic>)['drinks']
              .map((x) => Drink.createDrink(x)));
      List<CustomerReviews> customerReviews = List<CustomerReviews>.from(
          restaurantData['customerReviews']
              .map((x) => CustomerReviews.createCustomerReviews(x)));

      return Restaurant.createRestaurant(restaurantData,
          categories: categories,
          foods: foods,
          drinks: drinks,
          customerReviews: customerReviews);
    } else {
      throw Exception('Failed to load restaurant data');
    }
  }

  static Future<List<Restaurant>> searchRestaurants(String query) async {
    Uri apiURI = Uri.parse(_baseUrl + '/search?q=' + query);
    var apiResult = await http.get(apiURI);

    if (apiResult.statusCode == 200) {
      var jsonObject = json.decode(apiResult.body);
      var restaurantData = (jsonObject as Map<String, dynamic>)['restaurants'];

      List<Restaurant> restaurants = List<Restaurant>.from(
          restaurantData.map((x) => Restaurant.createRestaurant(x)));

      return (restaurants);
    } else {
      throw Exception('Failed to load restaurant data');
    }
  }
}
