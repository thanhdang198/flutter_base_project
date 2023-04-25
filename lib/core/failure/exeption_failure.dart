import 'failure.dart';

class ExceptionFailure extends Failure {
  final Exception message;
  const ExceptionFailure(this.message);
  @override
  List<Object?> get props => [message];

}
