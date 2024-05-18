import 'package:flutter_food_delivery/pages/cart/cart_page.dart';
import 'package:flutter_food_delivery/pages/food/popular_food_detail.dart';
import 'package:flutter_food_delivery/pages/food/recommended_food_detail.dart';
import 'package:flutter_food_delivery/pages/home/home_page.dart';
import 'package:flutter_food_delivery/pages/home/main_food_page.dart';
import 'package:flutter_food_delivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getSplashPage() => splashPage;
  static String getInitial() => initial;
  static String getPopularFood(int index, String page) =>
      '$popularFood?index=$index&page=$page';
  static String getRecommendedFood(int index, String page) =>
      '$recommendedFood?index=$index&page=$page';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
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
