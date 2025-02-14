import 'package:dartz/dartz.dart';

import 'failure/failure.dart';

abstract class UseCase<Params, Type> {
  Future<Either<Failure, Type>> call(Params params);
}
