import 'package:flutter/widgets.dart';

class CustomInherited extends InheritedWidget {
  final int counterValue;

  const CustomInherited({super.key, required this.counterValue, required super.child});

  @override
  bool updateShouldNotify(CustomInherited oldWidget) => oldWidget.counterValue != counterValue;

  static CustomInherited? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<CustomInherited>();
}
