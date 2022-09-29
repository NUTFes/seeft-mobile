import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seeft_mobile/model/model.dart';
import 'package:seeft_mobile/pages/cart_page/cart_page.dart';
import 'package:seeft_mobile/router/router.dart';
import 'package:seeft_mobile/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

import 'user_tile.dart';

class UserRoute extends GoRouteData {
  const UserRoute();

  @override
  Page<void> buildPage(BuildContext context) => const CupertinoPage(
        fullscreenDialog: true,
        child: UsersPage(),
      );
}

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('商品リスト'),
        leading: _CartButton(),
      ),
      body: _ListView(),
    );
  }
}

class _ListView extends ConsumerWidget {
  const _ListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ids = ref.watch(userIdsProvider).value;
    return ids == null
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: ids.length,
            itemBuilder: (_, index) => UserTile(id: ids[index]),
          );
  }
}

class _CartButton extends ConsumerWidget {
  const _CartButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationBarButton(
      text: ref.watch(
        cartTotalQuantityProvider.select((quantity) => 'カート($quantity)'),
      ),
      onPressed: ref.watch(cartEmptyProvider)
          ? null
          : () => const CartRoute().go(context),
    );
  }
}
