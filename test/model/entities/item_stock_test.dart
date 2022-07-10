import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:seeft_mobile/model/model.dart';
import 'package:seeft_mobile/util/util.dart';
import 'package:seeft_mobile/entity/entity.dart';

void main() {
  test('ItemStock.fromJson test', () async {
    const source = '''
    {
      "id": "100",
      "price": 200,
      "title": "test",
      "imageUrl": "https://mono0926.com/images/love_logo.png",
      "quantity": 5
    }
    ''';

    final json = jsonDecode(source) as JsonMap;
    final target = ItemStock.fromJson(json);
    final item = target.item;
    expect(item.id, '100');
    expect(item.price, 200);
    expect(item.title, 'test');
    expect(item.imageUrl, 'https://mono0926.com/images/love_logo.png');
    expect(target.quantity, 5);
  });
}
