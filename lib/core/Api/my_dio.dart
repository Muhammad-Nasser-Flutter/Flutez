
import 'package:dio/dio.dart';
import '../cache_helper/cache_helper.dart';
import 'endPoints.dart';

class MyDio {
  static late Dio dio;

  static init() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        validateStatus: (status) => true,);

    dio = Dio(baseOptions);
  }

  static Future<Response?> get({required String endPoint}) async {
    dio.options.headers = {
      "Authorization": "Bearer ${CacheHelper.getData(key: 'token')}",
    };
    return await dio.get(endPoint);
  }

  static Future<Response?> post(
      {required String endPoint,  data}) async {
    dio.options.headers = {
      "Authorization": "Bearer ${CacheHelper.getData(key: 'token')}",
    };
    return await dio.post(endPoint, data: data);
  }

  
}
