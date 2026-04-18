import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'product_list_screen.dart';

class CatalogShellScreen extends StatefulWidget {
  const CatalogShellScreen({super.key});

  static const routeName = '/';

  @override
  State<CatalogShellScreen> createState() => _CatalogShellScreenState();
}

class _CatalogShellScreenState extends State<CatalogShellScreen> {
  int _selectedIndex = 0;

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(onOpenProducts: () => _selectTab(1)),
          const ProductListScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _selectTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: 'Urunler',
          ),
        ],
      ),
    );
  }
}
