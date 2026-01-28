import 'package:flutter/material.dart';
import 'router.dart';

class CattleMarketplaceApp extends StatelessWidget {
  const CattleMarketplaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2E7D32),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFF9FAFB),
    );

    return MaterialApp.router(
      title: 'Cattle Marketplace',
      theme: theme,
      routerConfig: router,  // Fixed
      debugShowCheckedModeBanner: false,
    );
  }
}
