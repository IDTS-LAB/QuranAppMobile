import 'dart:ui' show Locale;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quran_app/features/quran/presentation/providers/quran_providers.dart';
import 'package:quran_app/features/settings/data/repositories/locale_repository_impl.dart';
import 'package:quran_app/features/settings/domain/repositories/locale_repository.dart';
import 'package:quran_app/features/settings/presentation/controllers/locale_controller.dart';

/// Locale persistence, backed by Drift settings.
final localeRepositoryProvider = Provider<LocaleRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return LocaleRepositoryImpl(database.settingsDao);
});

/// User locale override (`null` follows the system language).
final localeControllerProvider =
    AsyncNotifierProvider<LocaleController, Locale?>(
      LocaleController.new,
      retry: (_, _) => null,
    );
