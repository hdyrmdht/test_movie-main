abstract class Failure {
  String? statusCode;
  String? message;

  Failure({
     this.statusCode,
    this.message,
  });
}

class ServerFailure extends Failure {
  String? error, errorCode;

  ServerFailure({
     super.statusCode,
    super.message,
    this.error,
    this.errorCode,
  });
}
