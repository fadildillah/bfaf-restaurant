import 'package:flutter/material.dart';
import 'package:bfaf_submisi_restaurant_app/data/api/api_service.dart';
import 'package:bfaf_submisi_restaurant_app/data/model/restaurant_list.dart';
import 'package:bfaf_submisi_restaurant_app/data/model/restaurant_detail.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchRestaurantList(); // Fetch the list by default
  }

  RestaurantList? _restaurantList;
  RestaurantList? _searchRestaurant;
  RestaurantDetail? _restaurantDetail;
  late ResultState _state;

  String _message = '';

  String get message => _message;
  RestaurantList get result => _restaurantList!;
  RestaurantList get searchResult => _searchRestaurant!;
  RestaurantDetail get detailResult => _restaurantDetail!;
  ResultState get state => _state;

  Future<dynamic> _fetchRestaurantList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.fetchRestaurantList();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        _message = 'Data kosong';
      } else {
        _state = ResultState.hasData;
        _restaurantList = restaurant;
      }
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }

  Future<dynamic> fetchSearchRestaurant(String query) async {
    // Trigger search externally with the query
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.fetchSearchRestaurant(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        _message = 'No restaurants found';
      } else {
        _state = ResultState.hasData;
        _searchRestaurant = restaurant;
      }
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }

  Future<dynamic> fetchRestaurantDetail(String id) async {
    // Trigger detail fetching externally with the ID
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.fetchRestaurantDetail(id);
      _state = ResultState.hasData;
      _restaurantDetail = restaurant;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }
}
