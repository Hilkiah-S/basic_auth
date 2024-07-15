import 'package:auth/config/util/error/failure.dart';

/// Represents a failure in the API communication.
///
/// The [ApiFailure] class is a specific type of failure that occurs during API
/// communication. It extends the more general [Failure] class and provides
/// additional details, including an error message and an optional status code.
class ApiFailure extends Failure {
  /// Creates an [ApiFailure] with the specified error [message] and optional
  /// [statusCode].
  const ApiFailure({
    required super.message,
    super.statusCode,
  });
}
