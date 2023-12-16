import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
  scaffoldBackgroundColor: const Color(0xFFBEBEBE),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF6ADD87),
    onPrimary: Color(0xFF003917),
    primaryContainer: Color(0xFF005224),
    onPrimaryContainer: Color(0xFF87FAA1),
    secondary: Color(0xFFB7CCB6),
    onSecondary: Color(0xFF233425),
    secondaryContainer: Color(0xFF394B3B),
    onSecondaryContainer: Color(0xFFD3E8D2),
    tertiary: Color(0xFF8DD88B),
    onTertiary: Color(0xFF00390D),
    tertiaryContainer: Color(0xFF015317),
    onTertiaryContainer: Color(0xFFA9F5A5),
    error: Colors.red,
    errorContainer: Colors.red,
    onError: Colors.red,
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF003917),
    onBackground: Color(0xFFE2E3DE),
    surface: Color(0xFF003917),
    onSurface: Color(0xFFE2E3DE),
    surfaceVariant: Color(0xFF414941),
    onSurfaceVariant: Color(0xFFC1C9BE),
    outline: Color(0xFF005224),
    onInverseSurface: Color(0xFF1A1C19),
    inverseSurface: Color(0xFFE2E3DE),
    inversePrimary: Color(0xFF006D32),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF6ADD87),
    outlineVariant: Color(0xFF414941),
    scrim: Color(0xFF000000),
  ),
  dialogTheme: const DialogTheme(
    surfaceTintColor: Color(0xFFBEBEBE),
    backgroundColor: Color(0xFFBEBEBE),
    shadowColor: Color(0xFF005224),
  ),
  navigationRailTheme: const NavigationRailThemeData(
    unselectedIconTheme: IconThemeData(
      color: Colors.white,
    ),
    unselectedLabelTextStyle: TextStyle(
      color: Colors.white,
    ),
    selectedIconTheme: IconThemeData(
      color: Color(0xFF6ADD87),
    ),
    selectedLabelTextStyle: TextStyle(
      color: Color(0xFF6ADD87),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedItemColor: Colors.white,
    selectedItemColor: Color(0xFF6ADD87),
  ),
  expansionTileTheme: const ExpansionTileThemeData(shape: Border()),
  dividerColor: Colors.transparent,
  snackBarTheme: SnackBarThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 6,
    backgroundColor: const Color(0xFF233425),
    contentTextStyle: const TextStyle(color: Colors.white),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
    ),
  ),
  cardTheme: CardTheme(
    elevation: 6,
    surfaceTintColor: const Color.fromARGB(100, 66, 66, 66),
    shadowColor: Colors.black45,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    color: const Color.fromARGB(100, 66, 66, 66),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    shape: CircleBorder(),
  ),
);
