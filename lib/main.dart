import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:taste_tales/screens/categories.dart';
import 'package:taste_tales/screens/tabs.dart';
var kColorScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(
    255, 255, 205, 145));
var kDarkScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Color.fromARGB(255, 176, 101, 0));
/*
final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 0, 120, 131),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

final darkTheme = ThemeData.dark(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 159, 247, 255),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);
*/

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kDarkScheme,
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor: kDarkScheme.primaryContainer,
        foregroundColor: kDarkScheme.onPrimaryContainer,
      ),
      cardTheme: CardTheme().copyWith(
        color: kDarkScheme.secondaryContainer,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkScheme.primaryContainer,
          foregroundColor: kDarkScheme.onPrimaryContainer,
        ),
      ),
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: kDarkScheme.onSecondaryContainer,
          fontSize: 17,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.normal,
          color: kDarkScheme.onSecondaryContainer,
          fontSize: 15,
        ),
        titleSmall: TextStyle(
          fontWeight: FontWeight.normal,
          color: kDarkScheme.onSecondaryContainer,
          fontSize: 13,
        ),
      ),
    ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 17,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const TabsScreen(),
    );
  }
}
