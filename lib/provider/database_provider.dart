import 'package:bfaf_submisi_restaurant_app/data/db/database_helper.dart';
import 'package:bfaf_submisi_restaurant_app/data/model/restaurant_list.dart';
import 'package:bfaf_submisi_restaurant_app/provider/restaurant_provider.dart';
import 'package:flutter/foundation.dart';

class DatabaseProvider extends ChangeNotifier{
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}){
    _getFavorites();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantListSummary> _favorites = [];
  List<RestaurantListSummary> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'No favorites found';
    }
  }

  void addFavorite(RestaurantListSummary restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favorite = await databaseHelper.getFavoriteById(id);
    return favorite != null;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}