import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:flutter_food_delivery/widgets/app_icon.dart';
import 'package:flutter_food_delivery/widgets/big_text.dart';
import 'package:flutter_food_delivery/widgets/expandable_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.clear,
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Center(
                  child: BigText(
                    text: "Chinese Side",
                    size: Dimensions.font26,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.yellow,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/image/food0.png",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableText(
                    text:
                        "Do commodo adipisicing eu elit sunt commodo. Laboris mollit deserunt ad exercitation consectetur dolore enim est consectetur in cillum sit dolore sunt. Commodo sit ea sunt nisi exercitation. Pariatur consequat ea ullamco fugiat id sint aliqua deserunt in adipisicing dolor amet Lorem. Consectetur proident magna non cillum consectetur ea pariatur minim velit proident laboris occaecat consectetur eu. Mollit exercitation labore dolor est aliquip. Duis est velit eu officia in dolore occaecat ea officia. Cupidatat non ullamco ullamco laboris consequat in laborum eiusmod dolore voluptate irure eu nulla occaecat. Mollit pariatur duis pariatur sit cupidatat est consequat dolor laboris labore amet cupidatat ad non. Officia ea aute officia voluptate deserunt do et tempor adipisicing proident. Labore duis tempor mollit excepteur id anim deserunt fugiat culpa tempor Lorem ea. Deserunt mollit elit minim deserunt nulla ex laborum. Aliqua id ipsum ullamco consequat dolor. Nulla est do id culpa reprehenderit adipisicing aute Lorem consequat ullamco amet incididunt duis. Nulla excepteur exercitation et adipisicing ex veniam et est. Ea voluptate laborum labore minim Lorem consequat velit elit qui deserunt esse aliquip nulla occaecat. Veniam nostrud ipsum et adipisicing. Officia velit anim quis sit consectetur minim. Quis cupidatat magna eiusmod ipsum. Ea voluptate sunt ullamco labore irure voluptate do enim cillum aliqua excepteur qui ut. Mollit reprehenderit sunt et minim quis do elit ut commodo excepteur ut fugiat nulla. Officia magna labore velit ex cillum nostrud commodo mollit voluptate non et esse tempor. Duis nisi adipisicing officia consequat sint ad quis adipisicing adipisicing ut deserunt dolor ipsum. Voluptate consectetur consectetur ut velit id cillum anim mollit eiusmod occaecat ex. Adipisicing aliqua non elit voluptate ad. Consequat laboris magna aliquip et cupidatat incididunt nostrud aliquip commodo amet. Irure magna consequat mollit mollit ipsum culpa exercitation. Aliquip non aliqua minim occaecat non Lorem. Dolore nostrud ea fugiat in non ipsum fugiat anim proident reprehenderit id dolor reprehenderit dolor. Deserunt esse exercitation magna proident aliquip consequat et. Anim tempor elit in exercitation reprehenderit id ad adipisicing labore tempor labore pariatur dolor labore. Occaecat nostrud tempor consectetur nulla eiusmod Lorem cillum ullamco laboris aliqua pariatur non.",
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height10,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width30 * 2,
              vertical: Dimensions.height10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.remove,
                  iconColor: Colors.white,
                  iconSize: Dimensions.iconSize24,
                  backgroundColor: AppColors.mainColor,
                ),
                BigText(
                  text: "\$12.88" + " X " + "0",
                  color: AppColors.mainBlackColor,
                  size: Dimensions.font26,
                ),
                AppIcon(
                  icon: Icons.add,
                  iconColor: Colors.white,
                  iconSize: Dimensions.iconSize24,
                  backgroundColor: AppColors.mainColor,
                ),
              ],
            ),
          ),
          Container(
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
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height20,
                    horizontal: Dimensions.height20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: BigText(
                    text: "\$10 | Add to cart",
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
