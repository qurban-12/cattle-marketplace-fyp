import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  // State variables
  bool _isLoading = false;
  String? _errorMessage;
  String? _cnic;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get cnic => _cnic;

  // Text editing controllers
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Form key
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Check if CNIC exists (simulate API call)
  Future<bool> checkCnicExists(String cnic) async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Replace with actual Firebase/API call
      // For now, simulate: if CNIC is "42101-1234567-1", it exists
      bool exists = cnic == '42101-1234567-1';

      _cnic = cnic;
      _setLoading(false);
      return exists;
    } catch (e) {
      _setError('Failed to verify CNIC');
      _setLoading(false);
      return false;
    }
  }

  // Login with CNIC (existing user)
  Future<bool> loginWithCnic(String cnic) async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Replace with actual Firebase authentication
      _cnic = cnic;
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Login failed. Please try again.');
      _setLoading(false);
      return false;
    }
  }

  // Register new user
  Future<bool> registerUser({
    required String cnic,
    required String fullName,
    required String phone,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Replace with actual Firebase registration
      _cnic = cnic;
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Registration failed. Please try again.');
      _setLoading(false);
      return false;
    }
  }

  // Send OTP
  Future<bool> sendOtp(String phone) async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Replace with actual OTP sending logic
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Failed to send OTP');
      _setLoading(false);
      return false;
    }
  }

  // Helper methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Clear all data
  void clear() {
    cnicController.clear();
    fullNameController.clear();
    phoneController.clear();
    _cnic = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    cnicController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
  