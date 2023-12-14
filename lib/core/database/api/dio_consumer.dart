import '../../error/error_model.dart';
import '../../error/exceptions.dart';
import '../../utils/api_strings.dart';
import 'api_consumer.dart';


import 'package:dio/dio.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer(this.dio) {
    dio.options.baseUrl = ApiStrings.baseUrl;
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var res = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  handleDioException(e) {
    switch (e.type) {
      case DioExceptionType.badCertificate:
        throw BadCertificateException(ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeoutException(ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
        throw ServerException(ErrorModel.fromJson(e.response!.data));

      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400: //bad request
            throw BadRequestException(ErrorModel.fromJson(e.response!.data));

          case 401: //unauthorized
            throw UnauthorizedException(ErrorModel.fromJson(e.response!.data));

          case 403: //forbidden
            throw ForbiddenException(ErrorModel.fromJson(e.response!.data));

          case 404: //notFound
            throw NotFoundException(ErrorModel.fromJson(e.response!.data));

          case 409: //conflict
            throw ConflictException(ErrorModel.fromJson(e.response!.data));
          case 504:
            throw BadRequestException(ErrorModel.fromJson(e.response!.data));

          // print(e.response);
        }
      case DioExceptionType.cancel:
        throw ServerException(ErrorModel(status: 500, errorMessage: e.toString()));

      case DioExceptionType.unknown:
        throw ServerException(ErrorModel(status: 500, errorMessage: e.toString()));

      // throw ServerException('badResponse');
    }
  }
}


