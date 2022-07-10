import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:seeft_mobile/model/model.dart';

import '../../helper/dummy_items.dart';

void main() {
  test('CartController test', () async {
    final container = ProviderContainer(
      overrides: [
        itemStocks.overrideWithValue(
          AsyncValue.data(dummyItems),
        ),
      ],
    );
    final target = container.read(cartMapProvider.notifier);
    expect(container.read(cartEmptyProvider), isTrue);
    expect(container.read(cartTotalQuantityProvider), 0);
    expect(container.read(cartTotalPriceLabelProvider), '合計金額 0円+税');

    target.add('1');

    expect(container.read(cartEmptyProvider), isFalse);
    expect(container.read(cartTotalQuantityProvider), 1);
    expect(container.read(cartItemIdsProvider).first, '1');
    expect(container.read(cartTotalQuantityProvider), 1);
    expect(container.read(cartTotalPriceLabelProvider), '合計金額 100円+税');

    target.delete('1');

    expect(container.read(cartEmptyProvider), isTrue);
    expect(container.read(cartTotalQuantityProvider), 0);
    expect(container.read(cartTotalPriceLabelProvider), '合計金額 0円+税');
  });
}
