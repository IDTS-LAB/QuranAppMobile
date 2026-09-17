import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Noble Forest - Premium Quranic UI Theme
abstract final class AppTheme {
  /// Light theme configuration
  static ThemeData light() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.nobleGreen,
          brightness: Brightness.light,
          surface: AppColors.canvas,
          onSurface: AppColors.textPrimary,
          primary: AppColors.nobleGreen,
          onPrimary: AppColors.surface,
          secondary: AppColors.nobleGold,
          onSecondary: AppColors.surface,
        ),
        scaffoldBackgroundColor: AppColors.canvas,
        cardTheme: CardThemeData(
          color: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            side: BorderSide(
              color: AppColors.border,
              width: 1,
            ),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          margin: EdgeInsets.zero,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.nobleGreen,
            foregroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            textStyle: AppTypography.titleMedium,
            elevation: 0,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.nobleGreen,
            side: BorderSide(
              color: AppColors.nobleGreen,
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            textStyle: AppTypography.titleMedium,
            elevation: 0,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.nobleGreen,
            textStyle: AppTypography.titleMedium,
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.nobleGold,
          foregroundColor: AppColors.surface,
          shape: const CircleBorder(),
          elevation: 2,
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors.nobleGreen,
          circularTrackColor: AppColors.mutedSurface,
          linearTrackColor: AppColors.mutedSurface,
        ),
        dividerTheme: DividerThemeData(
          color: AppColors.border,
          thickness: 1,
          space: AppSpacing.section,
        ),
        textTheme: TextTheme(
          displayLarge: AppTypography.displayLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          displayMedium: AppTypography.displayMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          displaySmall: AppTypography.displaySmall.copyWith(
            color: AppColors.textPrimary,
          ),
          headlineLarge: AppTypography.headlineLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          headlineMedium: AppTypography.headlineMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          headlineSmall: AppTypography.headlineSmall.copyWith(
            color: AppColors.textPrimary,
          ),
          titleLarge: AppTypography.titleLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          titleMedium: AppTypography.titleMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          titleSmall: AppTypography.titleSmall.copyWith(
            color: AppColors.textPrimary,
          ),
          bodyLarge: AppTypography.bodyLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          bodyMedium: AppTypography.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          bodySmall: AppTypography.bodySmall.copyWith(
            color: AppColors.textPrimary,
          ),
          labelLarge: AppTypography.labelLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          labelMedium: AppTypography.labelMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          labelSmall: AppTypography.labelSmall.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      );

  /// Dark theme configuration
  static ThemeData dark() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.nobleGreen,
          brightness: Brightness.dark,
          surface: AppColors.surface,
          onSurface: AppColors.textPrimary,
          primary: AppColors.nobleGreen,
          onPrimary: AppColors.surface,
          secondary: AppColors.nobleGold,
          onSecondary: AppColors.surface,
        ),
        scaffoldBackgroundColor: AppColors.surface,
        cardTheme: CardThemeData(
          color: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            side: BorderSide(
              color: AppColors.border,
              width: 1,
            ),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          margin: EdgeInsets.zero,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.nobleGreen,
            foregroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            textStyle: AppTypography.titleMedium,
            elevation: 0,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.nobleGreen,
            side: BorderSide(
              color: AppColors.nobleGreen,
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            textStyle: AppTypography.titleMedium,
            elevation: 0,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.nobleGreen,
            textStyle: AppTypography.titleMedium,
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.nobleGold,
          foregroundColor: AppColors.surface,
          shape: const CircleBorder(),
          elevation: 2,
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors.nobleGreen,
          circularTrackColor: AppColors.mutedSurface,
          linearTrackColor: AppColors.mutedSurface,
        ),
        dividerTheme: DividerThemeData(
          color: AppColors.border,
          thickness: 1,
          space: AppSpacing.section,
        ),
        textTheme: TextTheme(
          displayLarge: AppTypography.displayLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          displayMedium: AppTypography.displayMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          displaySmall: AppTypography.displaySmall.copyWith(
            color: AppColors.textPrimary,
          ),
          headlineLarge: AppTypography.headlineLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          headlineMedium: AppTypography.headlineMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          headlineSmall: AppTypography.headlineSmall.copyWith(
            color: AppColors.textPrimary,
          ),
          titleLarge: AppTypography.titleLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          titleMedium: AppTypography.titleMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          titleSmall: AppTypography.titleSmall.copyWith(
            color: AppColors.textPrimary,
          ),
          bodyLarge: AppTypography.bodyLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          bodyMedium: AppTypography.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          bodySmall: AppTypography.bodySmall.copyWith(
            color: AppColors.textPrimary,
          ),
          labelLarge: AppTypography.labelLarge.copyWith(
            color: AppColors.textPrimary,
          ),
          labelMedium: AppTypography.labelMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          labelSmall: AppTypography.labelSmall.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      );
}