import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fe_clinicas_core/src/restClient/interceptors/auth_interceptor.dart';

final class RestClient extends DioForNative {
  RestClient(String baseUrl)
      : super(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60),
          ),
        ) {
    //construtor da classe RestClient
    interceptors.addAll(
      [
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
        AuthInterceptor(),
      ],
    );
  }

  RestClient get Auth {
    options.extra['AUTH_KEY'] = true;
    return this;
  }

  RestClient get unAuth {
    options.extra['AUTH_KEY'] = false;
    return this;
  }
}
