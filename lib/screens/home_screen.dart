import 'package:flutter/material.dart';

import '../data/product_repository.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductRepository _repository = const ProductRepository();
  final TextEditingController _searchController = TextEditingController();
  final Set<int> _cartProductIds = <int>{};

  late Future<List<Product>> _productsFuture;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _productsFuture = _repository.loadProducts();
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleCart(Product product) {
    setState(() {
      if (_cartProductIds.contains(product.id)) {
        _cartProductIds.remove(product.id);
      } else {
        _cartProductIds.add(product.id);
      }
    });
  }

  void _openDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ProductDetailScreen(
          product: product,
          isInCart: _cartProductIds.contains(product.id),
          onCartChanged: () => _toggleCart(product),
        ),
      ),
    );
  }

  List<Product> _filterProducts(List<Product> products) {
    if (_query.isEmpty) {
      return products;
    }

    return products.where((product) {
      return product.name.toLowerCase().contains(_query) ||
          product.category.toLowerCase().contains(_query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mini Katalog',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Badge(
              label: Text('${_cartProductIds.length}'),
              isLabelVisible: _cartProductIds.isNotEmpty,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Urunler yuklenirken bir sorun olustu.'),
            );
          }

          final products = _filterProducts(snapshot.data ?? <Product>[]);

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CatalogBanner(cartCount: _cartProductIds.length),
                      const SizedBox(height: 18),
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Urun veya kategori ara',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _query.isEmpty
                              ? null
                              : IconButton(
                                  tooltip: 'Aramayi temizle',
                                  onPressed: _searchController.clear,
                                  icon: const Icon(Icons.close),
                                ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (products.isEmpty)
                const SliverFillRemaining(
                  child: Center(child: Text('Aramaniza uygun urun bulunamadi.')),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  sliver: SliverGrid.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 240,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.74,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];

                      return ProductCard(
                        product: product,
                        isInCart: _cartProductIds.contains(product.id),
                        onTap: () => _openDetail(product),
                        onCartTap: () => _toggleCart(product),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _CatalogBanner extends StatelessWidget {
  const _CatalogBanner({required this.cartCount});

  final int cartCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF2563EB), Color(0xFF14B8A6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.storefront, color: Colors.white, size: 34),
          const SizedBox(height: 18),
          const Text(
            'Haftanin secili urunleri',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            cartCount == 0
                ? 'Urunleri incele, sepete ekle ve detay sayfasina gec.'
                : '$cartCount urun sepet simulasyonunda bekliyor.',
            style: const TextStyle(
              color: Color(0xFFEFF6FF),
              fontSize: 15,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
