// check if input is empty
String? isInputEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter something';
  }
  return null;
}

// check if input is email and not empty
String? isInputEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter something';
  }
  if (!validateEmail(value.trim().toLowerCase())) {
    return 'Enter valid email';
  }
  return null;
}

// check if input is email
bool validateEmail(String email) {
  // Regular expression pattern for email validation
  const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';

  // Create a RegExp object from the pattern
  final regex = RegExp(pattern);

  // Check if the email matches the pattern
  return regex.hasMatch(email);
}
