abstract class Result<T> {
  final T? _data;

  final Exception? _exception;

  static SuccessResult<T> success<T>(T data) => SuccessResult<T>(data);

  static FailureResult<T> failure<T>(Exception exp) => FailureResult<T>(exp);

  Result({T? data, Exception? exception})
      : _data = data,
        _exception = exception;
}

class SuccessResult<T> extends Result<T> {
  T get data => _data!;

  SuccessResult(T data) : super(data: data);
}

class FailureResult<T> extends Result<T> {
  Exception get exception => _exception!;

  FailureResult(Exception exception) : super(exception: exception);
}
