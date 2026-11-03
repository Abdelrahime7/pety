String toEnglishDigits(String value) {
  const arabicDigits = '٠١٢٣٤٥٦٧٨٩';
  const englishDigits = '0123456789';

  for (var i = 0; i < 10; i++) {
    value = value.replaceAll(arabicDigits[i], englishDigits[i]);
  }

  return value;
}
