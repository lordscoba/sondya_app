String mapToSearchString(Map<String, dynamic> map) {
  // Initialize an empty list to store key-value pairs
  List<String> keyValuePairs = [];

  // Iterate over the map and add non-empty key-value pairs to the list
  map.forEach((key, value) {
    // Check if the value is not empty (null or empty string)
    if (value != null && value.toString().isNotEmpty && value != "") {
      // Encode key and value to handle special characters
      String encodedKey = Uri.encodeQueryComponent(key);
      String encodedValue = Uri.encodeQueryComponent(value.toString());

      // Combine key and value into a key-value pair string
      String pair = '$encodedKey=$encodedValue';

      // Add the key-value pair string to the list
      keyValuePairs.add(pair);
    }
  });

  // Join all key-value pair strings with '&' to form the search string
  String searchString = keyValuePairs.join('&');

  return searchString;
}
