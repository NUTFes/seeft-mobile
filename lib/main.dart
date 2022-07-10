import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final helloWorldProvider = Provider((_) => 'Hello world');

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(helloWorldProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('HooksRiverpodExample')),
        body: Center(
          child: Text(value),
        ),
      ),
    );
  }
}
