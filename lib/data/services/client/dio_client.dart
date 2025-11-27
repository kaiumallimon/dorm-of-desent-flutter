import 'package:dio/dio.dart';
import 'package:dorm_of_decents/configs/environments.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late Dio dio;

  String? _accessToken;
  String? _refreshToken;

  factory ApiClient() => _instance;

  ApiClient._internal() {
    // Set base URL
    BaseOptions options = BaseOptions(
      baseUrl: AppEnvironment.apiBaseurl!,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    );

    dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Attach access token if available
          if (_accessToken != null) {
            options.headers['Authorization'] = 'Bearer $_accessToken';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError error, handler) async {
          // Handle 401 and refresh token
          if (error.response?.statusCode == 401 && _refreshToken != null) {
            try {
              await _refreshAccessToken();

              // Retry original request with new access token
              final opts = error.requestOptions;
              opts.headers['Authorization'] = 'Bearer $_accessToken';

              final cloneReq = await dio.request(
                opts.path,
                options: Options(method: opts.method, headers: opts.headers),
                data: opts.data,
                queryParameters: opts.queryParameters,
              );
              return handler.resolve(cloneReq);
            } catch (e) {
              // Refresh failed
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  // Set initial tokens
  void setTokens({required String accessToken, required String refreshToken}) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  // Refresh token logic
  Future<void> _refreshAccessToken() async {
    if (_refreshToken == null) throw Exception('No refresh token available');

    try {
      final response = await dio.post(
        'auth/refresh', // relative to base URL
        data: {'refresh_token': _refreshToken},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        _accessToken = response.data['access_token'];
        _refreshToken = response.data['refresh_token'];
        final expiresAt = response.data['expires_at'];
        print('Token refreshed successfully. Expires at: $expiresAt');
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      _accessToken = null;
      _refreshToken = null;
      throw Exception('Refresh token failed: $e');
    }
  }

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return dio.get(path, queryParameters: queryParameters);
  }

  // POST request
  Future<Response> post(String path, {dynamic data}) async {
    return dio.post(path, data: data);
  }
}
