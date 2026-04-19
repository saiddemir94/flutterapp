import 'package:flutter/material.dart';

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.color,
    required this.icon,
    required this.imageAsset,
    required this.description,
    required this.features,
  });

  final int id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final Color color;
  final IconData icon;
  final String imageAsset;
  final String description;
  final List<String> features;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      color: _colorFromHex(json['color'] as String),
      icon: _iconFromName(json['icon'] as String),
      imageAsset: json['image'] as String,
      description: json['description'] as String,
      features: List<String>.from(json['features'] as List<dynamic>? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'rating': rating,
      'color': color.value.toRadixString(16).padLeft(8, '0'),
      'icon': icon.codePoint,
      'image': imageAsset,
      'description': description,
      'features': features,
    };
  }

  static Color _colorFromHex(String hex) {
    return Color(int.parse('FF$hex', radix: 16));
  }

  static IconData _iconFromName(String name) {
    return switch (name) {
      'headphones' => Icons.headphones,
      'watch' => Icons.watch,
      'bag' => Icons.shopping_bag,
      'camera' => Icons.photo_camera,
      'coffee' => Icons.local_cafe,
      'speaker' => Icons.speaker,
      _ => Icons.inventory_2,
    };
  }
}
