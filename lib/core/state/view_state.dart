sealed class ViewState<T> {
  const ViewState();
}

class IdleState<T> extends ViewState<T> {
  const IdleState();
}

class LoadingState<T> extends ViewState<T> {
  const LoadingState();
}

class SuccessState<T> extends ViewState<T> {
  final T data;
  const SuccessState(this.data);
}

class ErrorState<T> extends ViewState<T> {
  final Exception exception;
  const ErrorState(this.exception);
}
