import 'package:auth/config/util/error/failure.dart';
import 'package:dartz/dartz.dart';

typedef FutureResult<T> = Future<Either<Failure, T>>;
