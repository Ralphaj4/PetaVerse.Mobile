import 'package:dio/dio.dart';

/// Attaches the current culture to every request as the `Accept-Language`
/// header (e.g. "en"). The value is read fresh per request via [cultureCode]
/// so a language change applies to subsequent calls without rebuilding the
/// client.
class CultureInterceptor extends Interceptor {
  CultureInterceptor(this.cultureCode);

  /// Returns the current culture code (e.g. "en"). Read per request.
  final String Function() cultureCode;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers['Accept-Language'] = cultureCode();
    handler.next(options);
  }
}
