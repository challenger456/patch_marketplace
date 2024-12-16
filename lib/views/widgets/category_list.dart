import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';

class CategoryList extends StatelessWidget {
  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // Map of category names to their corresponding image paths
    final Map<String, String> categoryImages = {
      'electronics': 'assets/closeup-view-computer-circuit-board-260nw-2492863813.webp',
      'jewelery': 'assets/images (1).jpeg',
      'men\'s clothing': 'assets/Essentials_2024_Mobile_600x800.jpeg',
      'women\'s clothing': 'assets/women-fashion-clothing.jpeg',
    };

    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: controller.categories.map((category) {
            return GestureDetector(
              onTap: () {
                controller.selectedCategory.value = category;
                controller.filterAndSortProducts();
              },
              child: Column(
                children: [
                  // Display category-specific image
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(categoryImages[category] ?? 'assets/images/default.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Capitalized category name
                  Text(
                    _capitalize(category),
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  /// Helper function to capitalize the first letter of a string
  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
