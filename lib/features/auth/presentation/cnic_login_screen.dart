import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:cattle_marketplace/utils/validators/cnic_validator.dart';
import 'package:cattle_marketplace/utils/formatters/cnic_input_formatter.dart';
import 'package:cattle_marketplace/features/auth/state/auth_controller.dart';
import 'package:cattle_marketplace/app/route_paths.dart';

class CnicLoginScreen extends StatelessWidget {
  const CnicLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthController(),
      child: const _CnicLoginContent(),
    );
  }
}

class _CnicLoginContent extends StatelessWidget {
  const _CnicLoginContent();

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF52B788),  // ⭐ Medium green (vibrant!)
              Color(0xFF74C69D),  // ⭐ Light teal-green (fresh!)
            ],
          ),
        ),





        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: authController.loginFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Cow Icon
                      Container(
                        width: 105,
                        height: 105,
                        decoration: BoxDecoration(
                          color: Colors.white,  // ✅ White background
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(13),  // ✅ Padding around logo
                        child: Image.asset(
                          'assets/logos/Cattle Silhouette.png',  // ✅ Your logo
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // App Name
                      Text(
                        'Cattle Marketplace',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: const Color(0xFF2D6A4F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Subtitle
                      Text(
                        'Buy & Sell Quality Livestock',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Welcome Back Title
                      Text(
                        'Welcome Back!',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Sign in text
                      Text(
                        'Sign in using your CNIC to continue',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // CNIC Input Field
                      TextFormField(
                        controller: authController.cnicController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [CnicInputFormatter()],
                        validator: CnicValidator.validate,
                        decoration: InputDecoration(
                          hintText: 'e.g. 42101-1234567-1',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 15,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          suffixIcon: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFF52B788), // Green
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.mic,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () {
                                // TODO: Implement voice input
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Voice input coming soon!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF52B788),
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Tap to Speak hint
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Tap to Speak CNIC',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      // Error Message
                      if (authController.errorMessage != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          authController.errorMessage!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ],

                      const SizedBox(height: 32),

                      // Login/Signup Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: authController.isLoading
                              ? null
                              : () => _handleContinue(context, authController),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF52B788),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: authController.isLoading
                              ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                              : const Text(
                            'CONTINUE',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Need Help
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 18,
                            color: Color(0xFF52B788),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              // TODO: Implement helpline call
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Helpline: 0300-1234567'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Need Help? Call Helpline',
                              style: TextStyle(
                                color: Color(0xFF52B788),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleContinue(
      BuildContext context,
      AuthController authController,
      ) async {
    if (authController.loginFormKey.currentState?.validate() ?? false) {
      final cnic = authController.cnicController.text;

      // Check if CNIC exists in database
      final exists = await authController.checkCnicExists(cnic);

      if (context.mounted) {
        if (exists) {
          // User exists - login directly
          final success = await authController.loginWithCnic(cnic);
          if (success && context.mounted) {
            // Navigate to role selection or home
            context.go(RoutePaths.roleSelection);
          }
        } else {
          // New user - navigate to signup
          context.push('/signup', extra: cnic);
        }
      }
    }
  }
}
