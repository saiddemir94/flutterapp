import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductDetailArguments {
  const ProductDetailArguments({
    required this.product,
    required this.isInCart,
  });

  final Product product;
  final bool isInCart;
}

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({required this.arguments, super.key});

  static const routeName = '/product-detail';

  final ProductDetailArguments arguments;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late bool _isInCart;

  @override
  void initState() {
    super.initState();
    _isInCart = widget.arguments.isInCart;
  }

  void _toggleCart() {
    setState(() {
      _isInCart = !_isInCart;
    });
  }

  void _closeDetail() {
    Navigator.pop(context, _isInCart);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.arguments.product;

    return WillPopScope(
      onWillPop: () async {
        _closeDetail();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Urun Detayi'),
          leading: IconButton(
            tooltip: 'Geri',
            onPressed: _closeDetail,
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              height: 240,
              decoration: BoxDecoration(
                color: product.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Padding(
                padding: const EdgeInsets.all(42),
                child: Image.asset(
                  product.imageAsset,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(product.icon, color: product.color, size: 118);
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              product.category,
              style: TextStyle(
                color: product.color,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star, color: Color(0xFFF59E0B), size: 20),
                const SizedBox(width: 6),
                Text(
                  product.rating.toStringAsFixed(1),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Text(
                  '${product.price.toStringAsFixed(2)} TL',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF111827),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Aciklama',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Text(
              product.description,
              style: const TextStyle(
                color: Color(0xFF4B5563),
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),
            FilledButton.icon(
              onPressed: () {
                final willAddToCart = !_isInCart;
                _toggleCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      willAddToCart
                          ? '${product.name} sepete eklendi.'
                          : '${product.name} sepetten cikarildi.',
                    ),
                  ),
                );
              },
              icon: Icon(
                _isInCart
                    ? Icons.remove_shopping_cart
                    : Icons.add_shopping_cart,
              ),
              label: Text(_isInCart ? 'Sepetten Cikar' : 'Sepete Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
