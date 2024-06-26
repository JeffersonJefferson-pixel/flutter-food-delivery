import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/controllers/popular_food_controller.dart';
import 'package:flutter_food_delivery/controllers/recommended_food_controller.dart';
import 'package:flutter_food_delivery/models/food_model.dart';
import 'package:flutter_food_delivery/routes/route_helper.dart';
import 'package:flutter_food_delivery/utils/app_constants.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/app_column.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:flutter_food_delivery/widgets/icon_and_text.dart';
import 'package:flutter_food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // slider
        GetBuilder<PopularFoodController>(
          builder: (popularFoodController) {
            return popularFoodController.isLoaded
                ? Container(
                    height: Dimensions.pageView,
                    child: PageView.builder(
                      itemBuilder: (context, index) {
                        FoodModel food =
                            popularFoodController.popularFoodList[index];
                        return GestureDetector(
                          onTap: () => Get.toNamed(
                            RouteHelper.getPopularFood(index, "home-page"),
                          ),
                          child: _buildPageItem(index, food),
                        );
                      },
                      itemCount: popularFoodController.popularFoodList.length,
                      controller: pageController,
                    ),
                  )
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          },
        ),
        // dot indicator
        GetBuilder<PopularFoodController>(builder: (popularFoodController) {
          return DotsIndicator(
            dotsCount: popularFoodController.popularFoodList.isEmpty
                ? 1
                : popularFoodController.popularFoodList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(
          height: Dimensions.height30,
        ),
        //  recommended text
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: "Food pairing",
                ),
              )
            ],
          ),
        ),

        // recommended food list
        GetBuilder<RecommendedFoodController>(
          builder: (recommendedFoodController) {
            return recommendedFoodController.isLoaded
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        recommendedFoodController.recommendedFoodList.length,
                    itemBuilder: (context, index) {
                      FoodModel food =
                          recommendedFoodController.recommendedFoodList[index];

                      return GestureDetector(
                        onTap: () => Get.toNamed(
                          RouteHelper.getRecommendedFood(
                            index,
                            "home-page",
                          ),
                        ),
                        child: _buildRecommendedFoodItem(food),
                      );
                    },
                  )
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          },
        ),
      ],
    );
  }

  Widget _buildPageItem(int index, FoodModel food) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = _scaleFactor;
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: Color(0xFF69c5df),
              image: DecorationImage(
                  image: NetworkImage(
                    "${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}/${food.img!}",
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Color(0xFFe8e8e8), offset: Offset(0, 5)),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0))
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15, left: 15, right: 15),
                child: AppColumn(text: food.name!),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRecommendedFoodItem(FoodModel food) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.width20,
        vertical: Dimensions.height10,
      ),
      child: Row(
        children: [
          Container(
            width: Dimensions.listViewImgSize,
            height: Dimensions.listViewImgSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: Colors.white38,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "${AppConstants.BASE_URL}/${AppConstants.UPLOAD_URL}/${food.img!}",
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: Dimensions.listViewTextContSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  bottomRight: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.width10, right: Dimensions.width10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(
                      text: food.name!,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    SmallText(text: "With chinese characteristics"),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndText(
                          icon: Icons.circle_sharp,
                          text: "Normal",
                          iconColor: AppColors.iconColor1,
                        ),
                        IconAndText(
                          icon: Icons.location_on,
                          text: "1.7km",
                          iconColor: AppColors.mainColor,
                        ),
                        IconAndText(
                          icon: Icons.access_time_rounded,
                          text: "32min",
                          iconColor: AppColors.iconColor2,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
