import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    required this.product,
    this.fit = BoxFit.contain,
    super.key,
  });

  final Product product;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      product.imageAsset,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Icon(product.icon, size: 56, color: product.color);
      },
    );
  }
}
