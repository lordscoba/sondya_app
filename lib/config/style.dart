import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,

  // Define the default brightness and colors.
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFEDB842),
    // ···
    brightness: Brightness.light,
  ),
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.bold,
    ),
    // ···
    titleLarge: GoogleFonts.playfairDisplay(
      fontSize: 30,
      fontStyle: FontStyle.italic,
    ),
    bodyMedium: GoogleFonts.merriweather(),
    displaySmall: GoogleFonts.pacifico(),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(
      color: Color(0xFF8F959E),
    ),
    labelStyle: const TextStyle(
      color: Color(0xFF8F959E),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color(0xFF000000).withOpacity(0.12),
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFEDB842)),
      borderRadius: BorderRadius.circular(8.0),
    ),
    contentPadding: const EdgeInsets.all(8.0),
    // Other InputDecoration properties can be set here
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0xFFEDB842)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(6.0), // Set the desired border radius here
        ),
      ),
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 32.0,
        ),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      foregroundColor: MaterialStateProperty.all<Color>(
        const Color(0xFFFFFFFF),
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return const Color(0xFFEDB842).withOpacity(0.04);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed)) {
            return const Color(0xFFEDB842).withOpacity(0.12);
          }
          return null; // Defer to the widget's default.
        },
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(6.0), // Set the desired border radius here
      ),
    ),
    padding: MaterialStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 32.0,
      ),
    ),
    textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  )),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,

  // Define the default brightness and colors.
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.purple,
    // ···
    brightness: Brightness.dark,
  ),

  primaryColor: Colors.indigo,
  brightness: Brightness.dark,
  // ... other properties
);

ThemeData buildAuthTheme(BuildContext context) {
  return Theme.of(context).copyWith(
    inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
          enabledBorder: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFEDB842),
            ),
          ),
        ),
  );
}
