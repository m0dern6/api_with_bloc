import 'package:api_with_bloc/Home_Screen/data/data_provider.dart';
import 'package:api_with_bloc/Home_Screen/model/product_model.dart';
import 'dart:convert';

class ProductRepository {
  DataProvider dataProvider = DataProvider();
  Future<List<Product>> getProducts() async {
    try {
      print('Making API request to https://dummyjson.com/products');
      final response = await DataProvider.getRequest(
          endpoint: 'https://dummyjson.com/products');
      print('Received response with status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        try {
          final jsonData = json.decode(response.body);
          ProductModel productModel = ProductModel.fromJson(jsonData);
          print('Parsed ${productModel.products.length} products');
          return productModel.products;
        } catch (e) {
          print('Error parsing JSON: $e');
          throw 'Failed to parse product data: $e';
        }
      } else {
        throw 'Failed to load products: ${response.statusCode}';
      }
    } catch (e) {
      print('Error in getProducts: $e');
      rethrow;
    }
  }
}
