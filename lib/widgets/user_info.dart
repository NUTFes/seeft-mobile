import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.title,
    required this.price,
    required this.bureau,
  });

  final String title;
  final String price;
  final int bureau;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyleMain = theme.textTheme.subtitle1;
    return Expanded(
      child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textStyleMain,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              price,
              style: textStyleMain,
            ),
          ),
        ],
      ),
      ),
    );
  }
}
