import 'package:flutter/material.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Widgetbook Setup Placeholder\nRequires "widgetbook" package to be installed.'),
        ),
      ),
    );
  }
}
