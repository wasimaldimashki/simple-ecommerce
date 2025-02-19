import 'package:dio/dio.dart';
import 'package:holool_ecommerce/core/shared/local_network.dart';

class ApiInterceptors extends Interceptor {
  ApiInterceptors();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = CashNetwork.getCashData(key: 'token');
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept-Language'] = 'en';
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await _handleTokenExpiration(err, handler);
      return;
    }
    return super.onError(err, handler);
  }

  Future<void> _handleTokenExpiration(
      DioException err, ErrorInterceptorHandler handler) async {
    await CashNetwork.clearCash();
  }
}
