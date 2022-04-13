class NetworkError extends Error {
  NetworkError(this.message, this.url);

  final String message;
  final String url;
}

class UnauthorizedError extends NetworkError {
  UnauthorizedError(url) : super("UNAUTHORIZED", url);
}

class NotFoundError extends NetworkError {
  NotFoundError(url) : super('Resource not found: $url', url);
}

class BadRequestError extends NetworkError {
  BadRequestError(url) : super("BAD_REQUEST", url);
}

class ServerError extends NetworkError {
  ServerError(url) : super("SERVER_ERROR", url);
}

class NoBaseUrlDefinedError extends Error {}
