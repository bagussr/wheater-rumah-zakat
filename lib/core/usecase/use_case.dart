import '../typedef/typedef.dart';

abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();
  FutureResult<Type> call(Params params);
}

abstract class Usecase<Type> {
  const Usecase();
  FutureResult<Type> call();
}
