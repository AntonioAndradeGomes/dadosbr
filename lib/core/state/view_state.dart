sealed class ViewState<T> {
  const ViewState();
}

class IdleState<T> extends ViewState<T> {
  const IdleState();

  @override
  String toString() => 'IdleState()';
}

class LoadingState<T> extends ViewState<T> {
  const LoadingState();

  @override
  String toString() => 'LoadingState()';
}

class SuccessState<T> extends ViewState<T> {
  final T data;
  const SuccessState(this.data);

  @override
  String toString() => 'SuccessState(data: $data)';
}

class ErrorState<T> extends ViewState<T> {
  final Exception exception;
  const ErrorState(this.exception);

  @override
  String toString() => 'ErrorState(exception: $exception)';
}
