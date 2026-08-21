

final emailRegex = RegExp(
  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
);
String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email is required';
  }

  if (!emailRegex.hasMatch(value.trim())) {
    return 'Enter a valid email address';
  }

  return null;
}