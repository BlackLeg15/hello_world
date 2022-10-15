import 'package:flutter/widgets.dart';

class DependencyInjectionWidget extends InheritedWidget {
  final List<Object> dependencies;
  const DependencyInjectionWidget({required this.dependencies, required super.child, super.key});

  T get<T extends Object>() {
    return dependencies.firstWhere((element) => element is T) as T;
  }

  @override
  bool updateShouldNotify(DependencyInjectionWidget oldWidget) {
    return dependencies != oldWidget.dependencies;
  }

  static DependencyInjectionWidget? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<DependencyInjectionWidget>();
}
