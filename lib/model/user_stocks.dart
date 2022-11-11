import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seeft_mobile/entity/user/user.dart';
import 'package:seeft_mobile/util/util.dart';
import 'package:seeft_mobile/entity/entity.dart';

final users = FutureProvider((ref) async {
  final result = await ref.watch(httpClientProvider).get(
        Uri.parse(
          'https://seeft-api.mashita1023.net/users',
        ),
      );
  final json = (await jsonDecode(result.body) as List).cast<JsonMap>();
  final list = json.map(User.fromJson).toList();
  return list;
});

final userMapProvider = Provider((ref) {
  final stocks = ref.watch(users).value ?? [];
  return Map.fromEntries(
    stocks.map((stock) {
      return MapEntry(stock.id, stock);
    }),
  );
});

final userIdsProvider = Provider(
  (ref) => ref
      .watch(users)
      .whenData((users) => users.map((user) => user.id).toList()),
);

final userProviders =
    Provider.family((ref, int id) => ref.watch(userMapProvider)[id]);

final usersProviders = Provider.family(
  (ref, int id) => ref.watch(userProviders(id)),
);
