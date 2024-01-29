import 'package:client/api/api.dart';
import 'package:client/services/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final dioProvider = Provider<Dio>((ref) {
  final storage = ref.read(secureStorageServiceProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: Api.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20.seconds,
      receiveTimeout: 20.seconds,
      sendTimeout: 20.seconds,
    ),
  );

  // customization
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true, // true
      responseHeader: false,
      responseBody: true, // true
      error: true, // true
      compact: true,
      maxWidth: 100,
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = storage.readToken();
        if (token != null) {
          options.headers.addAll(Api.headers(token));
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        // if there is no response, we continue
        if (error.response == null) return handler.next(error);

        final statusCode = error.response?.statusCode;
        final message = error.response?.data['message'];
        if (statusCode == 401 && message == 'Unauthorized') {
          // if the error is 401 and the message is 'Unauthorized'
          // the access token is not valid
          // we delete the tokens and redirect to login page
          storage.deleteToken();
        }
        return handler.next(error);
      },
    ),
  );

  return dio;
});
