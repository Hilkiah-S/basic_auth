import 'package:equatable/equatable.dart';

/// Represents a general failure with an associated error message and status
/// code.
///
/// The [Failure] class is an abstract base class for defining various types of
/// failures in your application. It includes an error message and an optional
/// status code to describe the failure condition.
abstract class Failure extends Equatable {
  /// The error message associated with the failure.
  final String message;

  /// An optional status code indicating the nature of the failure.
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];

  /// Creates a [Failure] with the specified [message] and an optional
  /// [statusCode].
  const Failure({
    required this.message,
    this.statusCode = 500,
  });
}
