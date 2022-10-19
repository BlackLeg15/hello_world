import 'package:flutter/widgets.dart';

import '../../core.dart';

abstract class Feature extends StatelessWidget {
  Widget get child;
  Map<Type, Object> get dependencies;

  const Feature({super.key});

  @override
  Widget build(BuildContext context) {
    final previousInjectedDependencies = DependencyInjectionWidget.of(context)?.dependencies;
    final providedDependencies = dependencies;
    if (previousInjectedDependencies != null) {
      providedDependencies.addAll(previousInjectedDependencies);
    }
    return DependencyInjectionWidget(
      dependencies: providedDependencies,
      child: child,
    );
  }
}
