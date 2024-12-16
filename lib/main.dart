// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:patch_marketplace/views/home_screen.dart';
//
// void main() => runApp(const ProductApp());
//
// class ProductApp extends StatelessWidget {
//   const ProductApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomeScreen(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patch_marketplace/views/cart_screen.dart';
import 'package:patch_marketplace/views/inbox_screen.dart';
import 'package:patch_marketplace/views/profile_screen.dart';
import 'package:patch_marketplace/views/sell_screen.dart';
import 'package:patch_marketplace/views/widgets/bottom_nav_bar.dart';
import 'controllers/bottom_nav_controller.dart';
import 'controllers/product_controller.dart';
import 'views/home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navigation Example',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  final BottomNavController bottomNavController = Get.put(BottomNavController());
  final ProductController productController = Get.put(ProductController());

  final List<Widget> screens = [
    HomeScreen(),
    CartScreen(),
    SellScreen(),
    InboxScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Add RefreshIndicator only to the HomeScreen
        if (bottomNavController.currentIndex.value == 0) {
          return RefreshIndicator(
            onRefresh: () async {
              // Call fetchProducts() to refresh data
              await productController.filteredProducts();
            },
            child: screens[bottomNavController.currentIndex.value],
          );
        } else {
          // Other screens do not need RefreshIndicator
          return screens[bottomNavController.currentIndex.value];
        }
      }),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
