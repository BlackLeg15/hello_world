import 'package:flutter/material.dart';

final globalKey = GlobalKey<_StatefulWidgetWithGlobalKeyState>();

class StatefulWidgetWithGlobalKey extends StatefulWidget {
  const StatefulWidgetWithGlobalKey({super.key});

  @override
  State<StatefulWidgetWithGlobalKey> createState() => _StatefulWidgetWithGlobalKeyState();
}

class _StatefulWidgetWithGlobalKeyState extends State<StatefulWidgetWithGlobalKey> {
  int _counter = 0;

  @override
  void initState() {
    debugPrint('--- INIT STATE ---');
    super.initState();
  }

  @override
  void activate() {
    debugPrint('--- ACTIVATE ---');
    super.activate();
  }

  @override
  void didChangeDependencies() {
    debugPrint('--- DID CHANGE DEPENDENCIES ---');
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    debugPrint('--- DEACTIVATE ---');
    super.deactivate();
  }

  @override
  void dispose() {
    debugPrint('--- DISPOSE ---');
    super.dispose();
  }

  void increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Stateful Widget with Global Key'),
        Text(_counter.toString()),
        ElevatedButton(onPressed: increment, child: const Text('Increment')),
      ],
    );
  }
}
