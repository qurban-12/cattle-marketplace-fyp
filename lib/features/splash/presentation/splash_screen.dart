import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cattle_marketplace/app/route_paths.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 4));

    if (mounted) {
      const hasSeenOnboarding = false;  // ✅ Added const

      if (hasSeenOnboarding) {
        context.go(RoutePaths.phoneLogin);  // <--- This will show your phone login screen

      } else {
        context.go(RoutePaths.onboarding);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const yellow = Color(0xFFF3A022);  // ✅ Added const

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/logos/Cattle Silhouette.png',
                  width: 350,
                  height: 350,
                ),
                const SizedBox(height: 16),
                Text(
                  'Cattle Marketplace',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Buy & Sell Quality Livestock',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: 44,
                  height: 44,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    valueColor: const AlwaysStoppedAnimation(yellow),
                    backgroundColor: yellow.withOpacity(0.15),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Loading...',
                  style: TextStyle(color: Colors.black45),
                ),
              ],
            ),
          ),
        ),
      ),
    );  // ✅ Make sure this closing bracket exists
  }
}
