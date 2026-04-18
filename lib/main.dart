import 'package:flutter/material.dart';

import 'screens/product_detail_screen.dart';
import 'screens/product_list_screen.dart';
import 'screens/shell_screen.dart';

void main() {
  runApp(const MiniKatalogApp());
}

class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xFFF7F8FA),
          foregroundColor: Color(0xFF111827),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xFFEFF6FF),
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            final isSelected = states.contains(MaterialState.selected);
            return TextStyle(
              color: isSelected
                  ? const Color(0xFF2563EB)
                  : const Color(0xFF6B7280),
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
            );
          }),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
        ),
      ),
      initialRoute: CatalogShellScreen.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case CatalogShellScreen.routeName:
            return MaterialPageRoute<void>(
              builder: (context) => const CatalogShellScreen(),
              settings: settings,
            );
          case ProductListScreen.routeName:
            return MaterialPageRoute<void>(
              builder: (context) => const ProductListScreen(),
              settings: settings,
            );
          case ProductDetailScreen.routeName:
            final args = settings.arguments;
            if (args is ProductDetailArguments) {
              return MaterialPageRoute<bool>(
                builder: (context) => ProductDetailScreen(arguments: args),
                settings: settings,
              );
            }

            return MaterialPageRoute<void>(
              builder: (context) => const _RouteErrorScreen(),
              settings: settings,
            );
          default:
            return MaterialPageRoute<void>(
              builder: (context) => const _RouteErrorScreen(),
              settings: settings,
            );
        }
      },
    );
  }
}

class _RouteErrorScreen extends StatelessWidget {
  const _RouteErrorScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Sayfa bulunamadi.')),
    );
  }
}
