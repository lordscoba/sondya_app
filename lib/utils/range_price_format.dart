String formatPriceRange(String priceRange) {
  List<String> parts = priceRange.split('_');
  if (parts.length == 2) {
    String minPrice = parts[0];
    String maxPrice = parts[1];
    return '\$$minPrice - \$$maxPrice';
  }
  return priceRange; // Return the original string if it doesn't match the format
}
