import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seeft_mobile/util/util.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required int id,
    required String name,
    required String mail,
    required int bureauId,
  }) = _User;
  User._();

  factory User.fromJson(JsonMap json) => _$UserFromJson(json);
}
