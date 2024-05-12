import 'package:flutter_food_delivery/pages/cart/cart_page.dart';
import 'package:flutter_food_delivery/pages/food/popular_food_detail.dart';
import 'package:flutter_food_delivery/pages/food/recommended_food_detail.dart';
import 'package:flutter_food_delivery/pages/home/main_load_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getInitial() => initial;
  static String getPopularFood(int index, String page) =>
      '$popularFood?index=$index&page=$page';
  static String getRecommendedFood(int index, String page) =>
      '$recommendedFood?index=$index&page=$page';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodPage()),
    GetPage(
      name: popularFood,
      page: () => PopularFoodDetail(
        index: int.parse(Get.parameters['index']!),
        page: Get.parameters['page']!,
      ),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () => RecommendedFoodDetail(
        index: int.parse(Get.parameters['index']!),
        page: Get.parameters['page']!,
      ),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartPage,
      page: () => CartPage(),
      transition: Transition.fadeIn,
    )
  ];
}
