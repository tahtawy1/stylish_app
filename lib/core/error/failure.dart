abstract class Failure {
  final String message;

  const Failure({required this.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}

class AuthFailure extends Failure {
  final String code;
  const AuthFailure({required this.code, required super.message});
}

class InsufficientStockFailure extends Failure {
  final String productTitle;
  const InsufficientStockFailure({
    required this.productTitle,
    required super.message,
  });
}
