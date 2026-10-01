import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/pokemon/presentation/bloc/list/pokemon_list_cubit.dart';
import 'package:pokedex/features/pokemon/presentation/view/pokemon_list_screen.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Корень приложения. Его запускают все таргеты: web, desktop, Android.
///
/// [locale] задаёт язык интерфейса. Без него язык берётся из системы, в
/// браузере из настроек браузера.
class App extends StatelessWidget {
  const App({super.key, this.locale});

  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    // BlocProvider создаёт Cubit один раз и закрывает его, когда сам уходит
    // из дерева. Всё, что ниже, получает Cubit через context.
    return BlocProvider(
      create: (context) => PokemonListCubit()..load(),
      child: MaterialApp(
        // Заголовок вкладки браузера тоже подпись, поэтому он из ARB.
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        debugShowCheckedModeBanner: false,
        // Шрифт лежит в assets/fonts: одинаковый на всех ОС и без сети.
        theme: ThemeData(fontFamily: 'Roboto'),
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const PokemonListScreen(),
      ),
    );
  }
}
