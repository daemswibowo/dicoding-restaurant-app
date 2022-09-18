import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/services/request_adapter_service.dart';

class RestaurantService extends RequestAdapterService {
  final String _url = "https://restaurant-api.dicoding.dev";

  /// Get restaurant list from API
  /// @usage
  /// await RestaurantService.list();
  Future<RestaurantListResponse> list() async {
    final http.Response response = await requestGet("$_url/list");

    if (response.statusCode == 200) {
      final restaurantResponse =
          RestaurantListResponse.fromJson(json.decode(response.body));

      return restaurantResponse;
    } else {
      throw Exception({
        'message': 'Failed to load restaurant list',
        'response': response.body
      });
    }
  }
}

final RestaurantService restaurantService = RestaurantService();
