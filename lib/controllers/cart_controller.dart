import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/data/repository/cart_repo.dart';
import 'package:flutter_food_delivery/models/cart_model.dart';
import 'package:flutter_food_delivery/models/food_model.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  CartController({required this.cartRepo});

  void addItem(FoodModel food, int quantity) {
    if (_items.containsKey(food.id)) {
      int totalQuantity = 0;
      _items.update(food.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        value.quantity = totalQuantity;

        return value;
      });

      if (totalQuantity <= 0) {
        _items.remove(food.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(
          food.id!,
          () => CartModel(
            id: food.id,
            name: food.name,
            price: food.price,
            img: food.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            food: food,
          ),
        );
      } else {
        Get.snackbar(
          "Item count",
          "You should at least add an item in the cart!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }

    update();
  }

  bool existInCart(FoodModel food) {
    if (_items.containsKey(food.id)) {
      return true;
    }
    return false;
  }

  getQuantity(FoodModel food) {
    if (_items.containsKey(food.id)) {
      return _items[food.id]!.quantity;
    }
    return 0;
  }

  int get totalQuantity =>
      _items.values.fold(0, (sum, item) => sum + item.quantity!);

  List<CartModel> get carts => _items.values.toList();

  int get totalPrice => _items.values
      .fold(0, (sum, item) => sum + (item.price! * item.quantity!));
}
