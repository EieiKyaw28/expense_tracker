import 'dart:ui';

class MonthModel {
  final String name;
  final Color lightColor;
  final Color darkColor;

  MonthModel({
    required this.name,
    required this.lightColor,
    required this.darkColor,
  });
}

final List<MonthModel> months = [
  MonthModel(
    name: 'January',
    lightColor: const Color(0xFFE0F7FA), // Icy Blue – Winter Chill
    darkColor: const Color(0xFF00ACC1), // Frosty Blue
  ),
  MonthModel(
    name: 'February',
    lightColor: const Color(0xFFF8BBD0), // Soft Pink – Valentine's vibe
    darkColor: const Color(0xFFC2185B), // Deep Romantic Pink
  ),
  MonthModel(
    name: 'March',
    lightColor: const Color(0xFFC8E6C9), // Light Green – New growth
    darkColor: const Color(0xFF2E7D32), // Rich Spring Green
  ),
  MonthModel(
    name: 'April',
    lightColor: const Color(0xFFFFF59D), // Light Yellow – Sunshine & blossoms
    darkColor: const Color(0xFFFBC02D), // Golden Spring Sun
  ),
  MonthModel(
    name: 'May',
    lightColor: const Color(0xFFFFCDD2), // Blooming Pink – Flower season
    darkColor: const Color(0xFFE91E63), // Bright Floral Pink
  ),
  MonthModel(
    name: 'June',
    lightColor: const Color(0xFFFFECB3), // Warm Amber – Early summer
    darkColor: const Color(0xFFFF9800), // Golden Orange
  ),
  MonthModel(
    name: 'July',
    lightColor: const Color(0xFFBBDEFB), // Sky Blue – Clear skies
    darkColor: const Color(0xFF1976D2), // Strong Blue
  ),
  MonthModel(
    name: 'August',
    lightColor: const Color(0xFFFFF3E0), // Light Orange – Summer sunsets
    darkColor: const Color(0xFFF57C00), // Deep Orange
  ),
  MonthModel(
    name: 'September',
    lightColor: const Color(0xFFDCE775), // Light Olive Green – Transition
    darkColor: const Color(0xFFAFB42B), // Earthy Green
  ),
  MonthModel(
    name: 'October',
    lightColor: const Color(0xFFFFCCBC), // Pumpkin/Autumn
    darkColor: const Color(0xFFD84315), // Rich Rust Orange
  ),
  MonthModel(
    name: 'November',
    lightColor: const Color(0xFFFFE0B2), // Brownish Orange – Fall leaves
    darkColor: const Color(0xFF8D6E63), // Brown – Earth tones
  ),
  MonthModel(
    name: 'December',
    lightColor: const Color(0xFFB3E5FC), // Snowy Blue – Winter theme
    darkColor: const Color(0xFF0288D1), // Chilly Blue
  ),
];
