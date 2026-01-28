class CnicValidator {
  // CNIC format: 42101-1234567-1 (13 digits with dashes)
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'CNIC is required';
    }

    // Remove dashes for validation
    String cnicDigits = value.replaceAll('-', '');

    // Check if it contains exactly 13 digits
    if (cnicDigits.length != 13) {
      return 'CNIC must be 13 digits';
    }

    // Check if all characters are digits
    if (!RegExp(r'^\d+$').hasMatch(cnicDigits)) {
      return 'CNIC must contain only numbers';
    }

    // Check correct format with dashes (optional)
    if (value.contains('-') && !RegExp(r'^\d{5}-\d{7}-\d{1}$').hasMatch(value)) {
      return 'Invalid CNIC format (e.g., 42101-1234567-1)';
    }

    return null; // Valid CNIC
  }

  // Format CNIC as user types: 42101-1234567-1
  static String formatCnic(String input) {
    String digits = input.replaceAll('-', '');

    if (digits.length <= 5) {
      return digits;
    } else if (digits.length <= 12) {
      return '${digits.substring(0, 5)}-${digits.substring(5)}';
    } else {
      return '${digits.substring(0, 5)}-${digits.substring(5, 12)}-${digits.substring(12)}';
    }
  }
}
