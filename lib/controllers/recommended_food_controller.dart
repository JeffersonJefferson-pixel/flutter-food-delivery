import 'package:flutter_food_delivery/data/repository/recommended_food_repo.dart';
import 'package:flutter_food_delivery/models/food_model.dart';
import 'package:get/get.dart';

class RecommendedFoodController extends GetxController {
  final RecommendedFoodRepo recommendedFoodRepo;
  List<dynamic> _recommendedFoodList = [];
  List<dynamic> get recommendedFoodList => _recommendedFoodList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  RecommendedFoodController({required this.recommendedFoodRepo});

  Future<void> getRecommendedFoodList() async {
    Response response = await recommendedFoodRepo.getRecommendedFoodList();
    if (response.statusCode == 200) {
      _recommendedFoodList = [];
      _recommendedFoodList.addAll(Food.fromJson(response.body).foods);
      _isLoaded = true;
      update();
    } else {}
  }
}
