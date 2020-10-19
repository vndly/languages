import 'dart:convert';
import 'package:dahttp/dahttp.dart';

abstract class OpenEndPoint<T> extends ValuedHttpClient<T> {
  OpenEndPoint() : super(logger: DefaultHttpLogger(headers: true, body: true));

  @override
  Future<HttpResult<T>> get(
    String url, {
    String host,
    Map<String, Object> path,
    Map<String, Object> query,
    Map<String, String> headers,
    dynamic body,
    Encoding encoding,
  }) async {
    return super.get(
      url,
      host: 'https://script.google.com',
    );
  }
}
