abstract class HttpClient<R> {
  Future<R> get(String path,
      {Map<String, dynamic>? queryParams, Map<String, dynamic>? headers});

  Future<R> post(String path,
      {dynamic body,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers});

  Future<R> put(String path,
      {dynamic body,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers});

  Future<R> patch(String path,
      {dynamic body,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers});

  Future<R> delete(String path,
      {Map<String, dynamic>? queryParams, Map<String, dynamic>? headers});
}
