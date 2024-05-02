import 'package:flutter_food_delivery/data/repository/popular_food_repo.dart';
import 'package:flutter_food_delivery/models/food_model.dart';
import 'package:get/get.dart';

class PopularFoodController extends GetxController {
  final PopularFoodRepo popularFoodRepo;
  List<dynamic> _popularFoodList = [];
  List<dynamic> get popularFoodList => _popularFoodList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  PopularFoodController({required this.popularFoodRepo});

  Future<void> getPopularFoodList() async {
    Response response = await popularFoodRepo.getPopularFoodList();
    if (response.statusCode == 200) {
      _popularFoodList = [];
      _popularFoodList.addAll(Food.fromJson(response.body).foods);
      _isLoaded = true;
      update();
    } else {}
  }
}
