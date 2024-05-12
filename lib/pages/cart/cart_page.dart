import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/controllers/popular_food_controller.dart';
import 'package:flutter_food_delivery/controllers/recommended_food_controller.dart';
import 'package:flutter_food_delivery/models/cart_model.dart';
import 'package:flutter_food_delivery/pages/home/main_load_page.dart';
import 'package:flutter_food_delivery/routes/route_helper.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/app_icon.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:flutter_food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // icons
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
                SizedBox(
                  width: Dimensions.width20 * 5,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(
                    RouteHelper.initial,
                  ),
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                )
              ],
            ),
          ),
          // cart items
          Positioned(
            top: Dimensions.height20 * 5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.height15,
              ),
              child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(
                    builder: (cartController) => ListView.builder(
                      itemCount: cartController.carts.length,
                      itemBuilder: (_, index) => _buildCartItem(
                        cartController.carts[index],
                        cartController,
                      ),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCartItem(CartModel cart, CartController cartController) {
    return Container(
      height: Dimensions.height20 * 5,
      width: double.maxFinite,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              int popularIndex = Get.find<PopularFoodController>()
                  .popularFoodList
                  .indexOf(cart.food);
              if (popularIndex >= 0) {
                Get.toNamed(
                    RouteHelper.getPopularFood(popularIndex, "cart-page"));
              } else {
                int recommendedIndex = Get.find<RecommendedFoodController>()
                    .recommendedFoodList
                    .indexOf(cart.food);
                Get.toNamed(
                  RouteHelper.getRecommendedFood(recommendedIndex, "cart-page"),
                );
              }
            },
            child: Container(
              width: Dimensions.height20 * 5,
              height: Dimensions.height20 * 5,
              margin: EdgeInsets.only(
                bottom: Dimensions.height10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}/${cart.img}",
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: Dimensions.width10,
          ),
          Expanded(
            child: Container(
              height: Dimensions.height20 * 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BigText(
                    text: cart.name!,
                    color: Colors.black54,
                  ),
                  SmallText(
                    text: "Spicy",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(
                        text: "\$ ${cart.price}",
                        color: Colors.redAccent,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Dimensions.height10,
                          horizontal: Dimensions.height10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        // increase/decrease quantity
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  cartController.addItem(cart.food!, -1),
                              child: Icon(
                                Icons.remove,
                                color: AppColors.signColor,
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.width10 / 2,
                            ),
                            BigText(text: cart.quantity!.toString()),
                            SizedBox(
                              width: Dimensions.width10 / 2,
                            ),
                            GestureDetector(
                              onTap: () =>
                                  cartController.addItem(cart.food!, 1),
                              child: Icon(
                                Icons.add,
                                color: AppColors.signColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
