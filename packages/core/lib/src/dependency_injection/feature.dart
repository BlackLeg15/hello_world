import 'package:flutter/widgets.dart';

import '../../core.dart';

abstract class Feature extends StatelessWidget {
  Widget get child;
  Map<Type, Object> dependencies({DependencyInjectionWidget? injector});

  const Feature({super.key});

  @override
  Widget build(BuildContext context) {
    final previousDependencyInjector = DependencyInjectionWidget.of(context);
    final previousInjectedDependencies = previousDependencyInjector?.dependencies;
    final providedDependencies = dependencies(injector: previousDependencyInjector);
    if (previousInjectedDependencies != null) {
      providedDependencies.addAll(previousInjectedDependencies);
    }
    return DependencyInjectionWidget(
      dependencies: providedDependencies,
      child: child,
    );
  }
}
