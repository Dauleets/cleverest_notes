// core/error/failure.dart
class Failure {
  final String message;

  Failure(this.message);
}

// core/utils/date_utils.dart
class DateUtils {
  // Your date utility methods here
}

// core/error/failures.dart
class DatabaseFailure extends Failure {
  DatabaseFailure(String message) : super(message);
}
