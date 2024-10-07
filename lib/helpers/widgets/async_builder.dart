import 'package:flutter/material.dart';

class AsyncBuilder<T> extends StatelessWidget {
  final Future<T>? future;
  final Widget Function(T? data) builder;
  final Widget Function(String error) errorBuilder;
  final Widget loadingWidget;
  const AsyncBuilder({
    super.key,
    required this.future,
    required this.builder,
    required this.errorBuilder,
    this.loadingWidget = const CircularProgressIndicator.adaptive(),
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return errorBuilder(snapshot.error.toString());
          } else if (snapshot.hasData && snapshot.data != null) {
            return builder(snapshot.data);
          }
        }
        return loadingWidget;
      },
    );
  }
}
