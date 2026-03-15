class ReportsState {
  final String? errorMessage;

  const ReportsState({
    this.errorMessage,
  });

  ReportsState copyWith({Object? errorMessage = _unset}) {
    return ReportsState(
      errorMessage: identical(errorMessage, _unset) ? this.errorMessage : errorMessage as String?,
    );
  }
}

const _unset = Object();