import 'package:flutter/material.dart';

///
extension BuildContextExtension on BuildContext {
  /// Returns the current [ColorScheme] from the theme.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns the current [TextTheme] from the theme.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Returns the size of the current media (screen).
  Size get size => MediaQuery.of(this).size;

  /// Returns the width of the current screen.
  double get width => size.width;

  /// Returns the height of the current screen.
  double get height => size.height;
}
