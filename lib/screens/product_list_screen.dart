import 'package:flutter/material.dart';

import '../data/product_repository.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  static const routeName = '/products';

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
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

  void _setCartStatus(Product product, bool isInCart) {
    setState(() {
      if (isInCart) {
        _cartProductIds.add(product.id);
      } else {
        _cartProductIds.remove(product.id);
      }
    });
  }

  void _toggleCart(Product product) {
    _setCartStatus(product, !_cartProductIds.contains(product.id));
  }

  Future<void> _openDetail(Product product) async {
    final result = await Navigator.pushNamed<bool>(
      context,
      ProductDetailScreen.routeName,
      arguments: ProductDetailArguments(
        product: product,
        isInCart: _cartProductIds.contains(product.id),
      ),
    );

    if (result != null) {
      _setCartStatus(product, result);
    }
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
          'Urun Listesi',
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
                      _ListBanner(cartCount: _cartProductIds.length),
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

class _ListBanner extends StatelessWidget {
  const _ListBanner({required this.cartCount});

  final int cartCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          const Icon(Icons.inventory_2_outlined, size: 34),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              cartCount == 0
                  ? 'Kartlardan bir urun secerek detay ekranina gec.'
                  : '$cartCount urun sepet simulasyonunda bekliyor.',
              style: const TextStyle(
                color: Color(0xFF374151),
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
