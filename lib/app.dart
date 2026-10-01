import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/common/navigation/app_router.dart';
import 'package:pokedex/common/theme/app_theme.dart';
import 'package:pokedex/common/theme/theme_cubit.dart';
import 'package:pokedex/features/pokemon/data/pokemon_repository.dart';
import 'package:pokedex/features/pokemon/domain/i_pokemon_repository.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/list/pokemon_list_cubit.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Корень приложения. Его запускают все таргеты: web, desktop, Android.
///
/// Здесь собираются зависимости. Только app.dart знает, какая реализация
/// стоит за [IPokemonRepository]. Остальные получают её через
/// `context.read<IPokemonRepository>()`.
///
/// [locale] задаёт язык интерфейса. Без него язык берётся из системы, в
/// браузере из настроек браузера.
class App extends StatelessWidget {
  const App({super.key, this.locale});

  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Тип указан явно: репозиторий ищут по интерфейсу, а не по классу.
        RepositoryProvider<IPokemonRepository>(
          create: (_) => const PokemonRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // Cubit списка создаётся один раз и живёт, пока работает
          // приложение. Поэтому список не теряется, пока открыта деталь.
          BlocProvider(
            create: (context) =>
                PokemonListCubit(context.read<IPokemonRepository>())..load(),
          ),
          // Тема относится ко всему приложению, поэтому её Cubit тоже здесь.
          BlocProvider(create: (_) => ThemeCubit()),
        ],
        // BlocBuilder пересобирает MaterialApp, когда меняется тема.
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) => MaterialApp.router(
            routerConfig: AppRouter.router,
            // Заголовок вкладки браузера тоже подпись, поэтому он из ARB.
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      ),
    );
  }
}
