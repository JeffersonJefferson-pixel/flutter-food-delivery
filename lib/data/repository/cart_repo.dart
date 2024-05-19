import 'dart:convert';

import 'package:flutter_food_delivery/models/cart_model.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> carts = [];
  List<String> cartHistory = [];

  void addToCarts(List<CartModel> cartList) {
    var time = DateTime.now().toString();
    carts = [];
    // convert to string
    cartList.forEach((cart) {
      cart.time = time;
      carts.add(jsonEncode(cart));
    });

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

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartHistoryList = [];
    cartHistory.forEach((element) =>
        cartHistoryList.add(CartModel.fromJson(jsonDecode(element))));

    return cartHistoryList;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < carts.length; i++) {
      cartHistory.add(carts[i]);
    }
    removeCart();
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
  }

  void removeCart() {
    carts = [];
    sharedPreferences.remove(AppConstants.CARTS);
  }
}
