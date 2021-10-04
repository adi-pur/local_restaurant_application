part of 'models.dart';

class CustomerReviews {
  String name, review, date;

  CustomerReviews(
      {required this.name, required this.review, required this.date});

  factory CustomerReviews.createCustomerReviews(Map<String, dynamic> object) =>
      CustomerReviews(
          name: object['name'], review: object['review'], date: object['date']);
}
