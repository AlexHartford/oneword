import 'package:flutter/material.dart';

const MaterialColor black = const MaterialColor(
  0xFF33313B,
  const <int, Color>{
    50: const Color(0xFF33313B),
    100: const Color(0xFF33313B),
    200: const Color(0xFF33313B),
    300: const Color(0xFF33313B),
    400: const Color(0xFF33313B),
    500: const Color(0xFF33313B),
    600: const Color(0xFF33313B),
    700: const Color(0xFF33313B),
    800: const Color(0xFF33313B),
    900: const Color(0xFF33313B),
  },
);

const Color contentColor = Color.fromRGBO(38, 38, 47, 1);
const Color modalBackgroundColor = Color.fromRGBO(241, 241, 241, 1);
const Color secondaryContentColor = Color.fromRGBO(111, 111, 118, 1);

/// Maximum logical pixel width for a modal window.
const double modalMaxWidth = 400;

/// Once the logic screen pixel width exceeds this number, show the ultra-wide
/// layout.
const double ultraWideLayoutThreshold = 1920;

/// Once the logic screen pixel width exceeds this number, show the wide layout.
const double wideLayoutThreshold = 800;

/// Devices with a logical screen pixel width less than this value
/// will not be permitted to rotate into landscape mode.
const double blockLandscapeThreshold = 750;

const TextStyle contentSmallStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 14,
  color: secondaryContentColor,
);

const TextStyle contentStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 16,
  color: contentColor,
);

const TextStyle contentLargeStyle = TextStyle(
  fontFamily: 'MontserratRegular',
  fontSize: 24,
  color: contentColor,
);

const TextStyle buttonTextStyle = TextStyle(
  fontFamily: 'MontserratMedium',
  fontSize: 16,
  color: contentColor,
);