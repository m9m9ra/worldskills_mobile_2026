import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:matule_api/exeptions.dart';

class ApiClient {
  static late final String baseUrl;
  String? _token;

  ApiClient._();

  static ApiClient? _instance;

  // Factory constructor that ensures only one instance
  factory ApiClient(String s, {required String baseUrl}) {
    baseUrl = baseUrl;
    _instance ??= ApiClient._();
    return _instance!;
  }

  void updateToken(String? token) {
    _token = token;
  }

  Map<String, String> _getHeaders({bool isMultipart = false}) {
    final headers = <String, String>{};
    if (!isMultipart) {
      headers['Content-Type'] = 'application/json';
    }
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  /// Обработчик HTTP ответов
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException.fromJson(response.statusCode, response.body);
    }
  }

  /// Метод обертка для безопасного выполнения сетевых запросов
  Future<dynamic> _safeRequest(Future<http.Response> Function() request) async {
    try {
      final response = await request();
      return _handleResponse(response);
    } on SocketException {
      throw NetworkException();
    }
  }

  Future<dynamic> get(String path, {Map<String, String>? queryParams}) async {
    return _safeRequest(() {
      final uri = Uri.parse(
        '$baseUrl$path',
      ).replace(queryParameters: queryParams);
      return http.get(uri, headers: _getHeaders());
    });
  }

  /// Future<dynamic> post
  /// ```
  ///  Future<dynamic> post(String path, {Object? body}) async {
  ///    return _safeRequest(() {
  ///      final uri = Uri.parse('$baseUrl$path');
  ///      return http.post(uri, headers: _getHeaders(), body: jsonEncode(body));
  ///    });
  ///  }
  /// ```
  Future<dynamic> post(String path, {Object? body}) async {
    return _safeRequest(() {
      final uri = Uri.parse('$baseUrl$path');
      return http.post(uri, headers: _getHeaders(), body: jsonEncode(body));
    });
  }

  Future<dynamic> patchMultipart(
    String path,
    Map<String, String> fields, {
    String? filePath,
    String? fileKey,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$path');
      final request = http.MultipartRequest('PATCH', uri);
      request.headers.addAll(_getHeaders(isMultipart: true));
      request.fields.addAll(fields);

      if (filePath != null && fileKey != null) {
        request.files.add(await http.MultipartFile.fromPath(fileKey, filePath));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return _handleResponse(response);
    } on SocketException {
      throw NetworkException();
    }
  }
}
