abstract class BaseStreamObject {
  final StreamObjectState state;
  final String errorMessage;

  const BaseStreamObject({
    required this.state,
    this.errorMessage = "",
  });
}

class StreamObject<T> extends BaseStreamObject {
  final T payload;

  const StreamObject({
    required StreamObjectState state,
    required this.payload,
    String errorMessage = "",
  }) : super(state: state, errorMessage: errorMessage);
}

class StreamListObject<T> extends BaseStreamObject {
  final List<T> payload;

  const StreamListObject({
    required StreamObjectState state,
    required this.payload,
    String errorMessage = "",
  }) : super(state: state, errorMessage: errorMessage);
}

enum StreamObjectState {
  error,
  success,
  loading,
}
