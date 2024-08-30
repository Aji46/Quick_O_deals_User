class ValidationUtils {
  static var validateUsername;

  static String? validate(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    } else if (value.contains(' ')) {
      return 'Spaces are not allowed in $fieldName';
    }
    return null;
  }

static String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  } 
  
  if (value.contains('  ')) {
    return 'Multiple spaces are not allowed in the phone number';
  } 
  
  if (!RegExp(r'^\+?[0-9\s\-\(\)]+$').hasMatch(value)) {
    return 'Invalid phone number format. Only numbers, spaces, dashes, and parentheses are allowed.';
  } 
  
  // Remove spaces and check for valid length and correct start digit
  final cleanedValue = value.replaceAll(RegExp(r'\s+'), '');
  if (!RegExp(r'^\+?[1-9][0-9]{9,14}$').hasMatch(cleanedValue)) {
    return 'Invalid phone number. Please enter a valid number with or without country code.';
  }
  
  return null;
}


  static String? validateemail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@gmail\.com$').hasMatch(value)) {
      return 'Please enter a valid Email address';
    }
    return null;
  }

  // New OTP validation method
  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    if (value.length != 6) {
      return 'OTP must be 6 digits';
    }
    // Additional OTP validation logic (if needed)
    return null;
  }

}
