import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seeft_mobile/model/model.dart';
import 'package:seeft_mobile/widgets/widgets.dart';

class UserTile extends ConsumerWidget {
  UserTile({
    required this.id,
  }) : super(key: ValueKey(id));

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const indent = 16.0;
    final user = ref.watch(usersProviders(id))!;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: indent),
          height: 96,
          child: Row(
            children: [
              const SizedBox(width: 8),
              ItemInfo(
                title: user.name,
                price: user.mail,
                info: Text(
                  '在庫',
                  style: theme.textTheme.caption,
                ),
              ),
            ],
          ),
        ),
        const Divider(indent: indent),
      ],
    );
  }
}

class _AddButton extends ConsumerWidget {
  const _AddButton({
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoButton(
      onPressed: ref.watch(hasStockProviders(id))
          ? () => ref.read(cartMapProvider.notifier).add(id)
          : null,
      child: const Text('追加'),
    );
  }
}
