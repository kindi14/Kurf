class Validator {
  static String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Full name is required';
    if (value.length < 3) return 'Name should be at least 3 characters';
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? confirmPasswordValidator(
      String password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please retype your password';
    }
    if (confirmPassword != password) return 'Passwords do not match';
    return null;
  }

  static String? weightValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Weight is required';
    final weight = double.tryParse(value);
    if (weight == null) return 'Enter a valid number';
    if (weight <= 0) return 'Weight must be more than 0';
    if (weight > 500) return 'Weight seems too high';
    return null;
  }
}
