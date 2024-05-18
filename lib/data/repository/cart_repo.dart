import 'dart:convert';

import 'package:flutter_food_delivery/models/cart_model.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> carts = [];

  void addToCarts(List<CartModel> cartList) {
    carts = [];
    // convert to string
    cartList.forEach((cart) => carts.add(jsonEncode(cart)));

    sharedPreferences.setStringList(AppConstants.CARTS, carts);
  }

  List<CartModel> getCarts() {
    List<String> cartStrings = [];
    if (sharedPreferences.containsKey(AppConstants.CARTS)) {
      cartStrings = sharedPreferences.getStringList(AppConstants.CARTS)!;
    }
    List<CartModel> carts = [];

    cartStrings.forEach(
        (cartString) => carts.add(CartModel.fromJson(jsonDecode(cartString))));

    return carts;
  }
}
