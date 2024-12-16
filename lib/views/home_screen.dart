import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import 'widgets/category_list.dart';
import 'widgets/product_card.dart';
import 'widgets/search_bar.dart';
import 'widgets/sort_buttons.dart';
import '../main.dart'; // Import your main app entry point

class HomeScreen extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Purple container with CustomSearchBar
          Stack(
            clipBehavior: Clip.none, // Allows overlapping content
            children: [
              Container(
                height: 120,
                width: double.infinity,
                color: Color(0xff7a6eae),
              ),
              Positioned(
                bottom: -25, // Adjust to place it at the bottom with overlap
                left: 15,
                right: 15,
                child: CustomSearchBar(), // Custom search bar
              ),
            ],
          ),
          SizedBox(height: 30), // To account for the floating search bar
          // Category title
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: Text(
              "Choose from any category",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Category list
          CategoryList(),
          // Count
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Obx(() {
              return Text(
                "${controller.visibleProductCount.value} products to choose from",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              );
            }),
          ),

          // Sort buttons
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 5, top: 5),
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SortButton(
                  text: "Lowest price first",
                  isSelected: controller.sortByLowestPrice.value,
                  onPressed: () {
                    controller.toggleSortByLowestPrice(true);
                  },
                ),
                SortButton(
                  text: "Highest price first",
                  isSelected: !controller.sortByLowestPrice.value,
                  onPressed: () {
                    controller.toggleSortByLowestPrice(false);
                  },
                ),
              ],
            )),
          ),

          SizedBox(height: 5),
          // Product grid
          Expanded(
            child: Obx(() {
              if (controller.filteredProducts.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: controller.filteredProducts[index],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
