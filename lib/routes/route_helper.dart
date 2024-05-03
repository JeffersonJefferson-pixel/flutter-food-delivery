import 'package:flutter_food_delivery/pages/food/popular_food_detail.dart';
import 'package:flutter_food_delivery/pages/food/recommended_food_detail.dart';
import 'package:flutter_food_delivery/pages/home/main_load_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";

  static String getInitial() => initial;
  static String getPopularFood(int index) => '$popularFood?index=$index';
  static String getRecommendedFood(int index) =>
      '$recommendedFood?index=$index';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodPage()),
    GetPage(
      name: popularFood,
      page: () => PopularFoodDetail(index: int.parse(Get.parameters['index']!)),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () =>
          RecommendedFoodDetail(index: int.parse(Get.parameters['index']!)),
      transition: Transition.fadeIn,
    )
  ];
}
