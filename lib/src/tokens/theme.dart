import 'package:realtimekit_core/realtimekit_core.dart';
import 'package:realtimekit_ui/src/tokens/color/status_color.dart';
import 'package:realtimekit_ui/src/tokens/font/font.dart';
import 'package:flutter/material.dart';

import '../di/di.dart';

class AppTheme {
  final RtkColorToken colorToken;
  AppTheme(this.colorToken);

  ThemeData get theme => ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme(
          error: StatusColor.error,
          brightness: Brightness.dark,
          tertiary: StatusColor.success,
          onError: colorToken.textColor.shade1000,
          primary: colorToken.brandColor.shade500,
          onPrimary: colorToken.textColor.shade1000,
          onSurface: colorToken.textColor.shade1000,
          onSecondary: colorToken.textColor.shade1000,
          outline: colorToken.backgroundColor.shade700,
          surface: colorToken.backgroundColor.shade900,
          secondary: colorToken.backgroundColor.shade1000,
          primaryContainer: backgroundColorSwatch.shade800,
          tertiaryContainer: backgroundColorSwatch.shade600,
          secondaryContainer: backgroundColorSwatch.shade700,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: textColorSwatch.shade1000,
            fontSize: fontSize.s300,
            fontWeight: FontWeight.w600,
            fontFamily: Font.name,
          ),
          displayMedium: TextStyle(
            color: textColorSwatch.shade1000,
            fontFamily: Font.name,
            fontSize: fontSize.s100,
            fontWeight: FontWeight.w500,
          ),
          displaySmall: TextStyle(
            color: textColorSwatch.shade1000,
            fontSize: fontSize.s75,
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: TextStyle(
            color: textColorSwatch.shade1000,
            fontSize: fontSize.s125,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontSize: fontSize.s88,
            color: textColorSwatch.shade700,
          ),
          bodyMedium: TextStyle(
            color: textColorSwatch.shade1000,
            fontSize: fontSize.s100,
          ),
          headlineSmall: TextStyle(
            color: textColorSwatch.shade1000,
            fontSize: fontSize.s100,
            fontWeight: FontWeight.w700,
          ),
          titleMedium: TextStyle(
            color: textColorSwatch.shade900,
            fontWeight: FontWeight.w300,
            fontSize: fontSize.s88,
          ),
        ),
      );
}
