import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.code});
  final String message;
  final String code;

  @override
  List<Object> get props => [message, code];
}

class InternalFailure extends Failure {
  const InternalFailure({required super.message, required super.code});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message}) : super(code: '500');
}
