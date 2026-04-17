import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/product.dart';

class ProductRepository {
  const ProductRepository();

  Future<List<Product>> loadProducts() async {
    final rawJson = await rootBundle.loadString('assets/data/products.json');
    final decoded = jsonDecode(rawJson) as List<dynamic>;

    return decoded
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
