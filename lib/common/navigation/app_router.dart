import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/common/widgets/app_scaffold.dart';
import 'package:pokedex/features/pokemon/presentation/view/pokemon_detail_screen.dart';
import 'package:pokedex/features/pokemon/presentation/view/pokemon_list_screen.dart';
import 'package:pokedex/l10n/app_localizations.dart';

/// Адреса экранов. Строки путей собраны здесь, чтобы не расходиться по
/// проекту. Переход из виджета: `context.push(AppRoutes.detail(id))`.
abstract final class AppRoutes {
  static const String list = '/';
  static String detail(int id) => '/pokemon/$id';
}

/// Какой адрес какой экран показывает.
///
/// Роутер только показывает экраны. Bloc и Cubit он не создаёт: Cubit списка
/// создан в корне приложения, Bloc детали создаёт сам экран детали.
abstract final class AppRouter {
  /// Длительность перехода между экранами, одна на оба направления.
  static const Duration _transition = Duration(milliseconds: 300);

  /// static final создаётся один раз при первом обращении, поэтому пересборка
  /// App не пересоздаёт роутер и не сбрасывает стек экранов.
  static final GoRouter router = _create();

  static GoRouter _create() {
    // Без этого флага push кладёт страницу в стек, а адрес во вкладке
    // остаётся «/», и ссылку на открытую запись не скопировать.
    GoRouter.optionURLReflectsImperativeAPIs = true;
    return GoRouter(
      initialLocation: AppRoutes.list,
      routes: [
        GoRoute(
          path: AppRoutes.list,
          pageBuilder: (context, state) =>
              _page(state, const PokemonListScreen()),
          routes: [
            // Вложенный маршрут: если открыть /pokemon/3 по ссылке, под
            // деталью всё равно лежит список, и стрелка «назад» есть.
            GoRoute(
              path: 'pokemon/:id',
              pageBuilder: (context, state) {
                final id = int.tryParse(state.pathParameters['id']!);
                return _page(
                  state,
                  id == null
                      ? const _NotFoundScreen()
                      : PokemonDetailScreen(id: id),
                );
              },
            ),
          ],
        ),
      ],
      // Без errorBuilder go_router покажет свою страницу на английском, мимо
      // ARB.
      errorBuilder: (context, state) => const _NotFoundScreen(),
    );
  }

  /// Новая страница въезжает справа и проявляется. При возврате Flutter
  /// проигрывает ту же анимацию в обратную сторону.
  static Page<void> _page(GoRouterState state, Widget child) {
    return CustomTransitionPage(
      // По этому ключу Navigator отличает одну страницу стека от другой.
      key: state.pageKey,
      transitionDuration: _transition,
      reverseTransitionDuration: _transition,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = animation.drive(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(curved),
          // Страница под новой немного уезжает влево.
          child: SlideTransition(
            position: Tween(
              begin: Offset.zero,
              end: const Offset(-0.3, 0),
            ).animate(secondaryAnimation),
            child: FadeTransition(opacity: curved, child: child),
          ),
        );
      },
    );
  }
}

/// Адреса нет среди маршрутов, или вместо номера записи в нём текст.
class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(child: Text(AppLocalizations.of(context).pageNotFound)),
    );
  }
}
