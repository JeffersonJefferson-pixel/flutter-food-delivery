import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_food_delivery/controllers/cart_controller.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/app_icon.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:flutter_food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var cartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < cartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(cartHistoryList[i].time)) {
        cartItemsPerOrder.update(cartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(cartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartOrderTimesToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPerOrder = cartOrderTimesToList();

    var listCounter = 0;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height10 * 10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  backgroundColor: AppColors.yellowColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: ListView(
                children: [
                  for (int i = 0; i < cartItemsPerOrder.length; i++)
                    Container(
                      height: Dimensions.height30 * 4,
                      margin: EdgeInsets.only(bottom: Dimensions.height20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (() {
                            DateTime parseDate =
                                DateFormat("yyyy-MM-dd HH:mm:ss")
                                    .parse(cartHistoryList[listCounter].time!);
                            var inputDate =
                                DateTime.parse(parseDate.toString());
                            var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
                            var outputDate = outputFormat.format(parseDate);

                            return BigText(text: outputDate);
                          }()),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Row(
                            children: [
                              Wrap(
                                direction: Axis.horizontal,
                                children: List.generate(
                                  itemsPerOrder[i],
                                  (index) {
                                    if (listCounter < cartHistoryList.length) {
                                      listCounter++;
                                    }
                                    return index < 2
                                        ? Container(
                                            height: Dimensions.height20 * 4,
                                            width: Dimensions.height20 * 4,
                                            margin: EdgeInsets.only(
                                                right: Dimensions.width10 / 2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius15 / 2),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    "${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}/${cartHistoryList[listCounter - 1].img}"),
                                              ),
                                            ),
                                          )
                                        : Container();
                                  },
                                ),
                              ),
                              Container(
                                height: Dimensions.height20 * 4,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SmallText(
                                      text: "Total",
                                      color: AppColors.titleColor,
                                    ),
                                    BigText(
                                      text: "${itemsPerOrder[i]} Items",
                                      color: AppColors.titleColor,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width10,
                                        vertical: Dimensions.height10 / 2,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius15 / 3),
                                        border: Border.all(
                                          width: 1,
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                      child: SmallText(
                                        text: "one more",
                                        color: AppColors.mainColor,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
