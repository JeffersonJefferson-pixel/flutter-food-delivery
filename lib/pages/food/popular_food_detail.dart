import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/controllers/popular_food_controller.dart';
import 'package:flutter_food_delivery/models/food_model.dart';
import 'package:flutter_food_delivery/pages/cart/cart_page.dart';
import 'package:flutter_food_delivery/routes/route_helper.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/app_column.dart';
import 'package:flutter_food_delivery/widgets/app_icon.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:flutter_food_delivery/widgets/expandable_text.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int index;
  final String page;
  const PopularFoodDetail({
    super.key,
    required this.index,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    PopularFoodController popularFoodController =
        Get.find<PopularFoodController>();
    FoodModel food = popularFoodController.popularFoodList[index];
    popularFoodController.initProduct(food, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // background
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    '${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}/${food.img}',
                  ),
                ),
              ),
            ),
          ),
          // icons
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (page == "cart-page") {
                      Get.toNamed(RouteHelper.cartPage);
                    } else {
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                  ),
                ),
                GetBuilder<PopularFoodController>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () => Get.toNamed(RouteHelper.cartPage),
                      child: Stack(
                        children: [
                          const AppIcon(
                            icon: Icons.shopping_cart_outlined,
                          ),
                          controller.totalQuantity >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.mainColor,
                                  ),
                                )
                              : Container(),
                          controller.totalQuantity >= 1
                              ? Positioned(
                                  right: 3,
                                  top: 3,
                                  child: BigText(
                                    text: controller.totalQuantity.toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          // indroduction
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: food.name!),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  BigText(text: "Introduce"),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableText(text: food.description!),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularFoodController>(builder: (popularFoodController) {
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.symmetric(
            vertical: Dimensions.height30,
            horizontal: Dimensions.width20,
          ),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20 * 2),
              topRight: Radius.circular(Dimensions.radius20 * 2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height20,
                  horizontal: Dimensions.height20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                ),
                // increase/decrease quantity
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => popularFoodController.setQuantity(false),
                      child: Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    BigText(text: popularFoodController.inCartItems.toString()),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    GestureDetector(
                      onTap: () => popularFoodController.setQuantity(true),
                      child: Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    )
                  ],
                ),
              ),
              // add to cart
              GestureDetector(
                onTap: () => popularFoodController.addItem(food),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height20,
                    horizontal: Dimensions.height20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: BigText(
                    text: "\$${food.price} | Add to cart",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
