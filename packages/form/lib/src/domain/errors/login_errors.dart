class LoginError {
  final String message;

  const LoginError({required this.message});

  @override
  String toString() => message;
}

class LoginUnknownError extends LoginError {
  const LoginUnknownError({required super.message});
}
