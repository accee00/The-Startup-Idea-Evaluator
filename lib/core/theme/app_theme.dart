import 'package:flutter/material.dart';

class AppTheme {
  // Primary Brand Colors
  static const Color primaryPurple = Color(0xFF8B5CF6); // Purple-500
  static const Color primaryBlue = Color(0xFF3B82F6); // Blue-500
  static const Color primaryDark = Color(0xFF7C3AED); // Purple-600
  static const Color primaryBlueDark = Color(0xFF2563EB); // Blue-600

  // Secondary Colors
  static const Color yellow = Color(0xFFFFE031); // Yellow-400
  static const Color orange = Color(0xFFFF8C00); // Orange-500
  static const Color green = Color(0xFF4ADE80); // Green-400
  static const Color red = Color(0xFFEF4444); // Red-500

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray900 = Color(0xFF111827);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF9FAFB); // gray-50
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color surfaceColor = Color(0xFFF3F4F6); // gray-100

  // Accent Colors with Opacity
  static const Color purpleLight = Color(0xFFF3E8FF); // Purple-50
  static const Color blueLight = Color(0xFFEFF6FF); // Blue-50
  static const Color yellowLight = Color(0xFFFEF3C7); // Yellow-50
  static const Color redLight = Color(0xFFFEE2E2); // Red-50
  static const Color greenLight = Color(0xFFECFDF5); // Green-50

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF8B5CF6), // Purple-500
    Color(0xFF3B82F6), // Blue-500
  ];

  static const List<Color> yellowOrangeGradient = [
    Color(0xFFFBBF24), // Yellow-400
    Color(0xFFF59E0B), // Orange-500
  ];

  static const List<Color> greenBlueGradient = [
    Color(0xFF34D399), // Green-400
    Color(0xFF3B82F6), // Blue-500
  ];

  // Text Colors (Light Theme)
  static const Color textPrimary = Color(0xFF111827); // gray-900
  static const Color textSecondary = Color(0xFF6B7280); // gray-500
  static const Color textLight = Color(0xFF9CA3AF); // gray-400
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0F172A); // slate-900
  static const Color darkSurface = Color(0xFF1E293B); // slate-800
  static const Color darkCard = Color(0xFF334155); // slate-700
  static const Color darkBorder = Color(0xFF475569); // slate-600

  // Dark Theme Text Colors
  static const Color darkTextPrimary = Color(0xFFF1F5F9); // slate-100
  static const Color darkTextSecondary = Color(0xFF94A3B8); // slate-400
  static const Color darkTextLight = Color(0xFF64748B); // slate-500
  static const Color darkTextOnPrimary = Color(0xFFFFFFFF);

  // Dark Theme Accent Colors
  static const Color darkPurpleLight = Color(0xFF1E1B4B); // indigo-900
  static const Color darkBlueLight = Color(0xFF1E3A8A); // blue-900
  static const Color darkYellowLight = Color(0xFF451A03); // amber-900
  static const Color darkRedLight = Color(0xFF450A0A); // red-900
  static const Color darkGreenLight = Color(0xFF14532D); // green-900

  // State Colors
  static const Color success = Color(0xFF10B981); // Green-500
  static const Color warning = Color(0xFFF59E0B); // Yellow-500
  static const Color error = Color(0xFFEF4444); // Red-500
  static const Color info = Color(0xFF3B82F6); // Blue-500

  // Interactive Colors
  static const Color activeBlue = Color(0xFF3B82F6);
  static const Color inactiveGray = Color(0xFF6B7280);
  static const Color hoverBlue = Color(0xFF2563EB);
  static const Color pressedBlue = Color(0xFF1D4ED8);

  // Border Colors
  static const Color borderLight = Color(0xFFE5E7EB); // gray-200
  static const Color borderMedium = Color(0xFFD1D5DB); // gray-300
  static const Color borderDark = Color(0xFF9CA3AF); // gray-400

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000); // Black with 10% opacity
  static const Color shadowMedium = Color(0x33000000); // Black with 20% opacity

  // Rating/Star Colors
  static const Color starActive = Color(0xFFFBBF24); // Yellow-400
  static const Color starInactive = Color(0xFFD1D5DB); // Gray-300

  // Category Colors (for different startup categories)
  static const Map<String, Color> categoryColors = {
    'AI/ML': Color(0xFF8B5CF6), // Purple
    'Tech': Color(0xFF3B82F6), // Blue
    'Health & Wellness': Color(0xFF10B981), // Green
    'Sustainability': Color(0xFF059669), // Emerald
    'Education': Color(0xFF7C3AED), // Violet
    'Finance': Color(0xFFF59E0B), // Amber
    'Social': Color(0xFFEF4444), // Red
    'Blockchain': Color(0xFF0891B2), // Cyan
  };

  // Create the light theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        brightness: Brightness.light,
        primary: primaryBlue,
        secondary: primaryPurple,
        surface: white,
        surfaceBright: backgroundLight,
        error: error,
        onPrimary: textOnPrimary,
        onSecondary: textOnPrimary,
        onSurface: textPrimary,
        onSurfaceVariant: textPrimary,
        onError: textOnPrimary,
        outlineVariant: starActive,
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: white,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: textSecondary),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: white,
        selectedItemColor: activeBlue,
        unselectedItemColor: inactiveGray,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: textOnPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderMedium),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderMedium),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: error),
        ),
        filled: true,
        fillColor: white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          color: textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          color: textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: TextStyle(
          color: textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          color: textLight,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Create the dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color Scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        brightness: Brightness.dark,
        primary: primaryBlue,
        secondary: primaryPurple,
        surface: darkSurface,
        background: darkBackground,
        error: error,
        onPrimary: darkTextOnPrimary,
        onSecondary: darkTextOnPrimary,
        onSurface: darkTextPrimary,
        onBackground: darkTextPrimary,
        onError: darkTextOnPrimary,
        outline: darkBorder,
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        foregroundColor: darkTextPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: darkTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: darkTextSecondary),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkSurface,
        selectedItemColor: primaryBlue,
        unselectedItemColor: darkTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: darkTextOnPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: error),
        ),
        filled: true,
        fillColor: darkSurface,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        hintStyle: TextStyle(color: darkTextSecondary),
        labelStyle: TextStyle(color: darkTextSecondary),
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: darkTextPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: darkTextPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: darkTextPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          color: darkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: darkTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: darkTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: darkTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: darkTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          color: darkTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          color: darkTextSecondary,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: TextStyle(
          color: darkTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: darkTextSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          color: darkTextLight,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Gradient Helpers
  static LinearGradient get primaryLinearGradient {
    return const LinearGradient(
      colors: primaryGradient,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  static LinearGradient get yellowOrangeLinearGradient {
    return const LinearGradient(
      colors: yellowOrangeGradient,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  static LinearGradient get greenBlueLinearGradient {
    return const LinearGradient(
      colors: greenBlueGradient,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  // Utility Methods
  static Color getCategoryColor(String category) {
    return categoryColors[category] ?? primaryBlue;
  }

  static Color getTextColorForBackground(Color backgroundColor) {
    // Calculate luminance to determine if text should be light or dark
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? textPrimary : textOnPrimary;
  }

  // Theme-aware color getters
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackground
        : backgroundLight;
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkCard
        : cardBackground;
  }

  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSurface
        : surfaceColor;
  }

  static Color getTextPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextPrimary
        : textPrimary;
  }

  static Color getTextSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextSecondary
        : textSecondary;
  }

  static Color getBorderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorder
        : borderLight;
  }

  static Color getAccentColor(BuildContext context, String type) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (type) {
      case 'purple':
        return isDark ? darkPurpleLight : purpleLight;
      case 'blue':
        return isDark ? darkBlueLight : blueLight;
      case 'yellow':
        return isDark ? darkYellowLight : yellowLight;
      case 'red':
        return isDark ? darkRedLight : redLight;
      case 'green':
        return isDark ? darkGreenLight : greenLight;
      default:
        return isDark ? darkBlueLight : blueLight;
    }
  }

  // Box Shadow Helpers
  static List<BoxShadow> get cardShadow {
    return [
      const BoxShadow(color: shadowLight, blurRadius: 4, offset: Offset(0, 2)),
    ];
  }

  static List<BoxShadow> get elevatedShadow {
    return [
      const BoxShadow(color: shadowMedium, blurRadius: 8, offset: Offset(0, 4)),
    ];
  }
}
