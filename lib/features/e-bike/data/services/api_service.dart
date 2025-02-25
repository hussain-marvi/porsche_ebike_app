import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService extends http.BaseClient {
  final http.Client _client = http.Client();
  final String baseUrl;
  final Map<String, String> defaultHeaders;

  ApiService({required this.baseUrl, this.defaultHeaders = const {}});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    try {
      request.headers.addAll(defaultHeaders);
      return await _client.send(request);
    } on SocketException {
      throw Exception("No Internet connection");
    } on HttpException {
      throw Exception("Couldn't find the resource");
    } on FormatException {
      throw Exception("Bad response format");
    }
  }

  Future<http.Response> getRequest(String endpoint,
      {Map<String, String>? headers}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final request = http.Request('GET', uri);

    if (headers != null) {
      request.headers.addAll(headers);
    }

    final streamedResponse = await send(request);
    return http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> postRequest(String endpoint,
      {Map<String, String>? headers, Object? body}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final request = http.Request('POST', uri);

    if (headers != null) {
      request.headers.addAll(headers);
    }
    if (body != null) {
      request.body = jsonEncode(body);
      request.headers['Content-Type'] = 'application/json';
    }

    final streamedResponse = await send(request);
    return http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> putRequest(String endpoint,
      {Map<String, String>? headers, Object? body}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final request = http.Request('PUT', uri);

    if (headers != null) {
      request.headers.addAll(headers);
    }
    if (body != null) {
      request.body = jsonEncode(body);
      request.headers['Content-Type'] = 'application/json';
    }

    final streamedResponse = await send(request);
    return http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> deleteRequest(String endpoint,
      {Map<String, String>? headers}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final request = http.Request('DELETE', uri);

    if (headers != null) {
      request.headers.addAll(headers);
    }

    final streamedResponse = await send(request);
    return http.Response.fromStream(streamedResponse);
  }
}
