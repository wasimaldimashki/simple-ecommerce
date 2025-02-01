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
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // يمكنك إضافة معالجة خاصة للاستجابات هنا
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // التعامل مع حالة انتهاء صلاحية التوكن
      await _handleTokenExpiration(err, handler);
      return;
    }
    return super.onError(err, handler);
  }

  Future<void> _handleTokenExpiration(
      DioException err, ErrorInterceptorHandler handler) async {
    // يمكنك إضافة منطق تجديد التوكن هنا
    // مثال: محاولة تجديد التوكن وإعادة المحاولة
    await CashNetwork.clearCash();
    // يمكنك إضافة توجيه المستخدم إلى صفحة تسجيل الدخول
  }
}
