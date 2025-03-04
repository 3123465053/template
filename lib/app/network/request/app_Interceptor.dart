import 'package:dio/dio.dart';

//拦截器
class AppInterceptor extends InterceptorsWrapper{

  //请求拦截
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }

  //响应拦截
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

}