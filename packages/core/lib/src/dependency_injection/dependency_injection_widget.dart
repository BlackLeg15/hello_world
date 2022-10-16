import 'package:collection/collection.dart';
import 'package:core/src/dependency_injection/dependency_injection_errors.dart';
import 'package:flutter/widgets.dart';

class DependencyInjectionWidget extends InheritedWidget {
  final Map<Type, Object> dependencies;
  const DependencyInjectionWidget({required this.dependencies, required super.child, super.key});

  T get<T extends Object>() {
    try {
      return dependencies[T] as T;
    } catch (e) {
      throw DependencyNotFound<T>();
    }
  }

  @override
  bool updateShouldNotify(DependencyInjectionWidget oldWidget) {
    return const MapEquality().equals(dependencies, oldWidget.dependencies);
  }

  static DependencyInjectionWidget? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<DependencyInjectionWidget>();
}
