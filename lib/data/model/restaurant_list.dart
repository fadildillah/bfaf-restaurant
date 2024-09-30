import 'dart:convert';

RestaurantList restaurantFromJson(String str) => RestaurantList.fromJson(json.decode(str));


class RestaurantList {
  bool error;
  String message;
  int count;
  List<RestaurantListSummary> restaurants;

  RestaurantList({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
    error: json["error"],
    message: json["message"],
    count: json["count"],
    restaurants: List<RestaurantListSummary>.from(json["restaurants"].map((x) => RestaurantListSummary.fromJson(x))),
  );

}

class RestaurantListSummary {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  
  RestaurantListSummary({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory RestaurantListSummary.fromJson(Map<String, dynamic> json) => RestaurantListSummary(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: json["rating"]?.toDouble(),
  );
}