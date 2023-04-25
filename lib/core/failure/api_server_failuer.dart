

import 'failure.dart';

class ApiServerFailure extends Failure{
  final String message;
  const ApiServerFailure(this.message);
  @override
  List<Object?> get props => [];
}