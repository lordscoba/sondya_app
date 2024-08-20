String sondyaSlugify(String text,
    {String delimiter = '-', bool lowercase = false}) {
  // Replace special characters with the delimiter
  text = text.replaceAll(RegExp(r'[^\w\s]'), delimiter);

  // Replace consecutive whitespace characters with the delimiter
  text = text.replaceAll(RegExp(r'\s+'), delimiter);

  // Remove leading and trailing delimiters
  text = text.trim().replaceAll(RegExp('^$delimiter+|$delimiter+\$'), '');

  // Convert to lowercase or uppercase based on the `lowercase` parameter
  if (lowercase) {
    text = text.toLowerCase();
  }

  return text;
}
