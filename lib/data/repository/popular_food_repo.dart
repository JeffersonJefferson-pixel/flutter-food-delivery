import 'package:flutter_food_delivery/data/api/api_client.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularFoodRepo extends GetxService {
  final ApiClient apiClient;
  PopularFoodRepo({required this.apiClient});

  Future<Response> getPopularFoodList() async {
    return await apiClient.getData(AppConstants.POPULAR_FOOD_URI);
  }
}
