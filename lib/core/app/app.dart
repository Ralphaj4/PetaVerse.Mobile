import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../localization/culture_provider.dart';
import '../localization/generated/app_localizations.dart';
import '../theme/app_theme.dart';
import 'router/app_router.dart';

/// Root widget: wires the router, theme, and localization (EN/AR/FR
/// with RTL support out of the box).
class PetaVerseApp extends ConsumerWidget {
  const PetaVerseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final culture = ref.watch(cultureProvider);
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: AppTheme.light,
      routerConfig: router,
      locale: culture.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
