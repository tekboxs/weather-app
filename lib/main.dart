import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project/screens/WeatherScreen/wheater_screen_view.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    runApp(const MyApp());
  }, (error, stackTrace) {
    showErrorDialog(FlutterErrorDetails(exception: error, stack: stackTrace));
  });
}

//outro arquivo app_widget ->

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: const CupertinoThemeData(),
      navigatorKey: navigatorKey,
      home: const WeatherScreenView(),
    );
  }
}

/// padronizar tema e add custom colors, mas teria que usar MaterialApp
//  https://edsonmsouza.medium.com/padronizando-temas-no-flutter-com-o-uso-da-theme-extension-f60fe9c79bcb

//outro arquivo default_dialogs ->

Future<void> showErrorDialog(
  FlutterErrorDetails? details, {
  String? title,
  String? message,
}) async {
  await showDialog(
    context: navigatorKey.currentState!.overlay!.context,
    builder: (context) {
      return AlertDialog(
        title: Text(title ?? 'Erro detectado'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message ?? "Por favor envie essa messagem para o suporte."),
              const SizedBox(height: 10),
              Text(
                "${details?.exception ?? ''} \n\n ${details?.stack ?? ''}",
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              //TODO - handle
            },
            child: const Text('VOLTAR AO INICIO'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('FECHAR'),
          ),
        ],
      );
    },
  );
}
