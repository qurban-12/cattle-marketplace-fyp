
import 'package:go_router/go_router.dart';
import 'package:cattle_marketplace/app/route_paths.dart';
import 'package:cattle_marketplace/features/splash/presentation/splash_screen.dart';
import 'package:cattle_marketplace/features/onboarding/presentation/onboarding_screen.dart';
import 'package:cattle_marketplace/features/auth/presentation/cnic_login_screen.dart';
import 'package:cattle_marketplace/features/auth/presentation/signup_screen.dart';
import 'package:cattle_marketplace/features/auth/presentation/phone_login_screen.dart';
import 'package:cattle_marketplace/features/auth/presentation/otp_screen.dart';
import 'package:cattle_marketplace/features/role/presentation/role_selection_screen.dart';
import 'package:cattle_marketplace/features/home_buyer/presentation/home_buyer_screen.dart';
// import 'package:cattle_marketplace/features/home_seller/presentation/home_seller_screen.dart';
import 'package:cattle_marketplace/features/home_seller/presentation/seller_home_screen.dart';


import 'package:cattle_marketplace/features/auth/presentation/home_screen.dart';
import 'package:cattle_marketplace/features/chat/presentation/chats_screen.dart';


final router = GoRouter(
  initialLocation: RoutePaths.splash, // App still starts at the splash screen
  routes: [
    GoRoute(
      path: RoutePaths.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RoutePaths.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),

    // ------ NEW: Phone-based login is now main login -------
    GoRoute(
      path: RoutePaths.phoneLogin, // '/phone-login'
      builder: (context, state) => const PhoneLoginScreen(),
    ),
    GoRoute(
      path: RoutePaths.otp, // '/otp'
      builder: (context, state) {
        final phoneNumber = state.extra as String;
        return OtpScreen(phoneNumber: phoneNumber);
      },
    ),

    GoRoute(
      path: RoutePaths.roleSelection,
      builder: (context, state) => const RoleSelectionScreen(),
    ),

    // Add routes:
    GoRoute(
      path: '/home-buyer',
      builder: (context, state) => const HomeBuyerScreen(),
    ),
    GoRoute(
      path: '/seller-home',
      //path: RoutePaths.sellerHome,
      builder: (context, state) => const SellerHomeScreen(),
     // builder: (context, state) => const HomeSellerScreen(),
    ),



    GoRoute(
      path: RoutePaths.home, // '/home'
      builder: (context, state) => const HomeScreen(),
    ),

    // OLD: Keep CNIC login (for later, only link if needed)
    GoRoute(
      path: RoutePaths.cnicLogin,
      builder: (context, state) => const CnicLoginScreen(),
    ),
    // Keep signup as before
    GoRoute(
      path: RoutePaths.signup,
      builder: (context, state) {
        final phoneNumber = state.extra as String?; // support passing phone from OTP
        return SignupScreen(phoneNumber: phoneNumber);
      },
    ),

    GoRoute(
      path: RoutePaths.chats,
      builder: (context, state) => const ChatsScreen(),
    ),


  ],
);
