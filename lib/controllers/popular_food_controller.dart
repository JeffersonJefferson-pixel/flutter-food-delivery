import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/data/repository/popular_food_repo.dart';
import 'package:flutter_food_delivery/models/food_model.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularFoodController extends GetxController {
  final PopularFoodRepo popularFoodRepo;
  List<dynamic> _popularFoodList = [];
  List<dynamic> get popularFoodList => _popularFoodList;
  late CartController _cartController;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

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

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (_inCartItems + quantity < 0) {
      Get.snackbar(
        "Item count",
        "You can't reduce more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if (_inCartItems + quantity > 20) {
      Get.snackbar(
        "Item count",
        "You can't add more!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(FoodModel food, CartController cartController) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cartController;
    bool exist = _cartController.existInCart(food);
    if (exist) {
      _inCartItems = _cartController.getQuantity(food);
    }
  }

  void addItem(FoodModel food) {
    _cartController.addItem(food, _quantity);
    _quantity = 0;
    _inCartItems = _cartController.getQuantity(food);
    update();
  }

  int get totalQuantity => _cartController.totalQuantity;
}
