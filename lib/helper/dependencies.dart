import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/controllers/popular_food_controller.dart';
import 'package:flutter_food_delivery/controllers/recommended_food_controller.dart';
import 'package:flutter_food_delivery/data/api/api_client.dart';
import 'package:flutter_food_delivery/data/repository/cart_repo.dart';
import 'package:flutter_food_delivery/data/repository/popular_food_repo.dart';
import 'package:flutter_food_delivery/data/repository/recommended_food_repo.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  // repos
  Get.lazyPut(() => PopularFoodRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedFoodRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: sharedPreferences));

  // controllers
  Get.lazyPut(() => PopularFoodController(popularFoodRepo: Get.find()));
  Get.lazyPut(() => RecommendedFoodController(recommendedFoodRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
