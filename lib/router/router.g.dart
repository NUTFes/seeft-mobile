// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<GoRoute> get $appRoutes => [
      $itemsRoute,
    ];

GoRoute get $itemsRoute => GoRouteData.$route(
      path: '/',
      factory: $ItemsRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'cart',
          factory: $CartRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'user',
          factory: $UserRouteExtension._fromState,
        ),
      ],
    );

extension $ItemsRouteExtension on ItemsRoute {
  static ItemsRoute _fromState(GoRouterState state) => const ItemsRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location, extra: this);
}

extension $CartRouteExtension on CartRoute {
  static CartRoute _fromState(GoRouterState state) => const CartRoute();

  String get location => GoRouteData.$location(
        '/cart',
      );

  void go(BuildContext context) => context.go(location, extra: this);
}

extension $UserRouteExtension on UserRoute {
  static UserRoute _fromState(GoRouterState state) => const UserRoute();

  String get location => GoRouteData.$location(
        '/user',
      );

  void go(BuildContext context) => context.go(location, extra: this);
}
