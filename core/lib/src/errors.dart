class IllegalStateError extends Error {
  IllegalStateError(this.message);

  final String message;
}

class NoBuilderFoundError extends Error{
  NoBuilderFoundError(this.uiType);
  final String uiType;
}

class InitStepError extends Error {}