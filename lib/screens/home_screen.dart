import 'package:flutter/material.dart';

import 'product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mini Katalog',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
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
                const Icon(Icons.storefront, color: Colors.white, size: 38),
                const SizedBox(height: 22),
                const Text(
                  'Mini Katalog Uygulamasi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    height: 1.12,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Ana sayfadan urun listesine gec, kartlari incele ve detay ekraninda sepete ekleme simulasyonunu dene.',
                  style: TextStyle(
                    color: Color(0xFFEFF6FF),
                    fontSize: 15,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, ProductListScreen.routeName);
                  },
                  icon: const Icon(Icons.grid_view_rounded),
                  label: const Text('Urun Listesine Git'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const _FeatureRow(
            icon: Icons.home_outlined,
            title: 'Ana sayfa',
            description: 'Uygulama giris ekrani ve listeye gecis.',
          ),
          const _FeatureRow(
            icon: Icons.grid_view_rounded,
            title: 'Urun listesi',
            description: 'GridView ile kart tabanli urun tasarimi.',
          ),
          const _FeatureRow(
            icon: Icons.open_in_new_rounded,
            title: 'Urun detayi',
            description: 'Navigator ve route arguments ile veri tasima.',
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: const Color(0xFF2563EB)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
