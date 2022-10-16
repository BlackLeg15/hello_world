abstract class DependencyInjectionError {
  const DependencyInjectionError();
}

class DependencyNotFound<T> extends DependencyInjectionError {
  const DependencyNotFound();

  @override
  String toString() => "$T type dependency hasn't been found";
}
