import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/services/restaurant_service.dart';

class RestaurantStore extends ChangeNotifier {
  final RestaurantService restaurantService;

  RestaurantStore({required this.restaurantService}) {
    fetchRestaurantList();
  }

  late Restaurant? item = null;
  late List<Restaurant> _items = [];
  late List<Restaurant> searchItems = [];
  late bool loading = false;
  late bool error = false;

  List<Restaurant> get items => _items;

  int get total => _items.length;

  void setItems(List<Restaurant> newItems) {
    _items = newItems;
    notifyListeners();
  }

  void setItem(Restaurant newItem) {
    item = newItem;
    notifyListeners();
  }

  void setSearchItems(List<Restaurant> newItems) {
    searchItems = newItems;
    notifyListeners();
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setError(bool value) {
    error = value;
    notifyListeners();
  }

  /// Fetch restaurant data
  /// @usage
  /// fetchRestaurantList();
  Future<dynamic> fetchRestaurantList() async {
    setLoading(true);
    setError(false);

    try {
      final RestaurantListResponse response =
          await restaurantService.list();
      setItems(response.restaurants);
    } catch (e) {
      setError(true);
    } finally {
      setLoading(false);
    }
  }

  /// fetch search restaurant data
  /// @usage
  /// restaurantStore.fetchSearchRestaurant('someQuery');
  Future<dynamic> fetchSearchRestaurant(String query) async {
    setLoading(true);
    setError(false);
    try {
      final RestaurantSearchResponse response =
      await restaurantService.search(query);
      setSearchItems(response.restaurants);
    } catch (e) {
      setError(true);
    } finally {
      setLoading(false);
    }
  }

  /// fetch restaurant detail data
  /// @usage
  /// restaurantStore.fetchDetail('restaurantId');
  Future<dynamic> fetchDetail(String restaurantId) async {
    setLoading(true);
    setError(false);
    try {
      final RestaurantDetailResponse response =
      await restaurantService.detail(restaurantId);
      setItem(response.restaurant);
    } catch (e) {
      setError(true);
    } finally {
      setLoading(false);
    }
  }
}
