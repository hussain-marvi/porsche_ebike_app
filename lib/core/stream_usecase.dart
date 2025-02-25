// lib/domain/usecases/stream_usecase.dart
abstract class StreamUseCase<Type, Params> {
  Stream<Type> call(Params params);
}
