import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seeft_mobile/pages/cart_page/cart_page.dart';
import 'package:seeft_mobile/pages/items_page/items_page.dart';
import 'package:seeft_mobile/pages/users_page/users_page.dart';

part 'router.g.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    routes: $appRoutes,
    debugLogDiagnostics: kDebugMode,
  ),
);

@TypedGoRoute<ItemsRoute>(
  path: '/',
  routes: [
    TypedGoRoute<CartRoute>(path: 'cart'),
    TypedGoRoute<UserRoute>(path: 'user'),
  ],
)
class ItemsRoute extends GoRouteData {
  const ItemsRoute();
  @override
  Widget build(BuildContext context) => const ItemsPage();
}
