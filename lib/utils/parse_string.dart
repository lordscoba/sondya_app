int parseDuration(String input) {
  // Define a regular expression to match digits at the beginning of the string
  final regex = RegExp(r'^(\d+)');

  // Try to match the regex with the input string
  final match = regex.firstMatch(input);

  // If a match is found, return the matched group (as an integer)
  if (match != null) {
    return int.parse(match.group(0)!);
  }

  // If no match is found, return 0 or handle it as you see fit
  return 0;
}
