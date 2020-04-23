import 'package:meta/meta.dart';

@sealed
abstract class Result<T> {
  R whenWithResult<R>(
    R Function(Empty) empty,
    R Function(Loading) loading,
    R Function(Success<T>) success,
    R Function(Error) error,
  ) {
    if (this is Empty) {
      return empty(this as Empty);
    } else if (this is Loading) {
      return loading(this as Loading);
    } else if (this is Success<T>) {
      return success(this as Success<T>);
    } else if (this is Error) {
      return error(this as Error);
    } else {
      throw new Exception('Unhandled part, could be anything');
    }
  }
}

class Empty<T> extends Result<T> {}

class Loading<T> extends Result<T> {}

class Success<T> extends Result<T> {
  final T value;

  Success(this.value);
}

class Error<T> extends Result<T> {
  final Error exception;

  Error(this.exception);
}
