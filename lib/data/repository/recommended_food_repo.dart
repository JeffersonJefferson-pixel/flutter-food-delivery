import 'package:flutter_food_delivery/data/api/api_client.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedFoodRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedFoodRepo({required this.apiClient});

  Future<Response> getRecommendedFoodList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_FOOD_URI);
  }
}
