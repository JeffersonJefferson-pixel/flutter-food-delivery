import 'package:flutter_food_delivery/controllers/popular_food_controller.dart';
import 'package:flutter_food_delivery/controllers/recommended_food_controller.dart';
import 'package:flutter_food_delivery/data/api/api_client.dart';
import 'package:flutter_food_delivery/data/repository/popular_food_repo.dart';
import 'package:flutter_food_delivery/data/repository/recommended_food_repo.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

Future<void> init() async {
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  Get.lazyPut(() => PopularFoodRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedFoodRepo(apiClient: Get.find()));

  Get.lazyPut(() => PopularFoodController(popularFoodRepo: Get.find()));
  Get.lazyPut(() => RecommendedFoodController(recommendedFoodRepo: Get.find()));
}
