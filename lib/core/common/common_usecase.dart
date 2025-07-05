import 'package:meta/meta.dart';

@immutable
abstract class CommonUseCase<Type, Params> {
  Future<Type> call(Params? params);
}
