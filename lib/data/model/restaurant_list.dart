import 'dart:convert';

RestaurantList restaurantFromJson(String str) => RestaurantList.fromJson(json.decode(str));

class RestaurantList {
  bool error;
  String message;
  int founded; // Change this to int to match the API response
  List<RestaurantListSummary> restaurants;

  RestaurantList({
    required this.error,
    required this.message,
    required this.founded, // Add this field
    required this.restaurants,
  });

  factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
    error: json["error"],
    message: json["message"] ?? '', // Provide a default message if null
    founded: json["founded"] ?? 0, // Capture the number of founded results
    restaurants: json['restaurants'] != null
          ? List<RestaurantListSummary>.from(json['restaurants'].map((x) => RestaurantListSummary.fromJson(x)))
          : [], // Return an empty list if restaurants are null
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "founded": founded,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

class RestaurantListSummary {
  String id;
  String name;
  String? description;
  String? pictureId;
  String city;
  double rating;

  RestaurantListSummary({
    required this.id,
    required this.name,
    this.description,
    this.pictureId,
    required this.city,
    required this.rating,
  });

  factory RestaurantListSummary.fromJson(Map<String, dynamic> json) {
    return RestaurantListSummary(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      pictureId: json["pictureId"],
      city: json["city"],
      rating: json["rating"]?.toDouble() ?? 0.0, // Default to 0.0 if null
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "rating": rating,
  };
}
