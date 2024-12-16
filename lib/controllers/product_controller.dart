// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
//
// import '../data/models/product_model.dart';
// import '../data/services/product_service.dart';
//
// class ProductController extends GetxController {
//   var products = <Product>[].obs;
//   var filteredProducts = <Product>[].obs;
//   var categories = <String>[].obs;
//   var selectedCategory = ''.obs;
//   var sortByLowestPrice = true.obs;
//   var visibleProductCount = 0.obs;  // Add this reactive variable
//
//   final ProductService _service = ProductService();
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchProducts();
//   }
//
//   void fetchProducts() async {
//     try {
//       var productList = await _service.fetchProducts();
//       products.assignAll(productList);
//       categories.assignAll(productList.map((e) => e.category).toSet().toList());
//       filteredProducts.assignAll(productList);
//       visibleProductCount.value = filteredProducts.length;  // Update count initially
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     }
//   }
//
//   void filterAndSortProducts() {
//     var tempList = products;
//     if (selectedCategory.value.isNotEmpty) {
//       tempList = tempList
//           .where((p) => p.category == selectedCategory.value)
//           .toList()
//           .obs;
//     }
//     if (sortByLowestPrice.value) {
//       tempList.sort((a, b) => a.price.compareTo(b.price));
//     } else {
//       tempList.sort((a, b) => b.price.compareTo(a.price));
//     }
//     filteredProducts.assignAll(tempList);
//     visibleProductCount.value = filteredProducts.length;  // Update count after filtering/sorting
//   }
// }
import 'package:get/get.dart';
import '../data/models/product_model.dart';
import '../data/services/product_service.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  var categories = <String>[].obs;
  var selectedCategory = ''.obs;
  var sortByLowestPrice = true.obs;
  var visibleProductCount = 0.obs; // Reactive variable for visible products

  final ProductService _service = ProductService();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      var productList = await _service.fetchProducts();
      products.assignAll(productList);
      categories.assignAll(productList.map((e) => e.category).toSet().toList());
      filteredProducts.assignAll(productList);
      updateVisibleProductCount(); // Update visible count initially
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void filterAndSortProducts() {
    var tempList = List<Product>.from(products); // Create a copy of the list
    if (selectedCategory.value.isNotEmpty) {
      tempList = tempList.where((p) => p.category == selectedCategory.value).toList();
    }
    if (sortByLowestPrice.value) {
      tempList.sort((a, b) => a.price.compareTo(b.price)); // Sort by lowest price
    } else {
      tempList.sort((a, b) => b.price.compareTo(a.price)); // Sort by highest price
    }
    filteredProducts.assignAll(tempList);
    updateVisibleProductCount(); // Update visible count after filtering/sorting
  }

  void updateVisibleProductCount() {
    visibleProductCount.value = filteredProducts.length;
  }

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
    filterAndSortProducts();
  }

  void toggleSortByLowestPrice(bool value) {
    sortByLowestPrice.value = value;
    filterAndSortProducts();
  }
}
