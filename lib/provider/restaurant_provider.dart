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
  RestaurantList? get searchResult => _searchRestaurant;
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

  Future<void> fetchSearchRestaurant(String query) async {
    if (query.isEmpty) return; // Early return if query is empty

    _state = ResultState.loading; // Set state to loading
    notifyListeners(); // Notify listeners about the state change

    try {
      final restaurantList = await apiService.fetchSearchRestaurant(query); // Fetch results from API
      if (restaurantList.restaurants.isEmpty) {
        _state = ResultState.noData; // Update state if no data found
        _searchRestaurant = restaurantList; // Save the empty list
        _message = 'No restaurants found';
      } else {
        _state = ResultState.hasData; // Update state to has data
        _searchRestaurant = restaurantList; // Save the search results
      }
    } catch (e) {
      _state = ResultState.error; // Update state to error if an exception is thrown
      _message = 'Error: $e';
    }

    notifyListeners(); // Notify listeners about the state change
  }


  Future<dynamic> fetchRestaurantDetail(String id) async {
    // Trigger detail fetching externally with the ID
    try {
      _state = ResultState.loading;
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
