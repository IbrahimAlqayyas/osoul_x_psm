import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../localization/01_translation_keys.dart';
import '../logging/logging.dart';
import '../shared_widgets/snackbar.dart';

class ApiClient {
  // Private constructor
  ApiClient._internal();

  // Singleton instance
  static final ApiClient _instance = ApiClient._internal();

  // Factory constructor to return the singleton instance
  factory ApiClient() => _instance;

  http.Client client = http.Client();

  // 👇 Add flag here
  final bool _isFailureDialogVisible = false;

  /// Generalized API request method
  Future<void> request({
    required String serviceName,
    required RequestType requestType,
    required Uri uri,
    required Map<String, String> headers,
    Map<String, dynamic>? body,
    bool printUrl = true,
    bool printStatusCode = true,
    bool printResponseBody = false,
    bool printHeaders = false,
    bool printCurl = false,
    int timeoutDuration = 120,
    Function(dynamic)? onSuccess,
    Function(dynamic)? onError,
    Function(dynamic)? onException,
    Function(ErrorResponse)? onBadEntries400,
    Function(ErrorResponse)? onBadEntries422,
    Function(ErrorResponse)? onInvalidRequest401,
    Function(ErrorResponse)? onNotAuthorized403,
    Function(ErrorResponse)? onNotFound404,
    Function(ErrorResponse)? onAlreadyExist409,
    Function(ErrorResponse)? onNotAcceptable406,
    Function(dynamic)? onForbidden403,
    Function(dynamic)? onSuccessFullResponse,
    bool? showSnackBarWidget = true,
  }) async {
    try {
      // 🚫 Check internet before request
      // final hasNet = await ConnectivityService().hasInternet();
      // final hasNet = true;
      // if (!hasNet) {
      //   _showFailureDialogOnce();
      //   _handleException(
      //     serviceName,
      //     noInternetConnectionTitle.tr,
      //     onException,
      //     showSnackBarWidget: false,
      //   );
      //   return;
      // }

      // Print the cURL command if enabled
      if (printCurl) _printCurlCommand(requestType, uri, headers, body);

      // Execute request
      final response = await _performRequest(
        requestType: requestType,
        uri: uri,
        headers: headers,
        body: body,
        timeoutDuration: timeoutDuration,
      );

      _printDebugLogs(
        serviceName: serviceName,
        uri: uri,
        headers: headers,
        response: response,
        printUrl: printUrl,
        printStatusCode: printStatusCode,
        printResponseBody: printResponseBody,
        printHeaders: printHeaders,
      );

      _handleResponse(
        serviceName: serviceName,
        response: response,
        onSuccess: onSuccess,
        onError: onError,
        onBadEntries400: onBadEntries400,
        onBadEntries422: onBadEntries422,
        onInvalidRequest401: onInvalidRequest401,
        onNotAuthorized403: onNotAuthorized403,
        onNotFound404: onNotFound404,
        onAlreadyExist409: onAlreadyExist409,
        onNotAcceptable406: onNotAcceptable406,
        onSuccessFullResponse: onSuccessFullResponse,
      );
    } catch (e, s) {
      if (e is TimeoutException) {
        _handleException(serviceName, requestTimedOutMessage.tr, onException);
      } else if (e is HttpException) {
        _handleException(serviceName, httpErrorOccurred.trParams({'error': '$e'}), onException);
      } else {
        _handleException(serviceName, unexpectedError.trParams({'error': '$e'}), onException);
        kLog(s);
      }
    }
  }

  /// 👇 Helper to show failure dialog only once
  // void _showFailureDialogOnce() {
  //   if (_isFailureDialogVisible) return;
  //   _isFailureDialogVisible = true;

  //   showNoInternetDialog(isDismissible: true).then((_) {
  //     _isFailureDialogVisible = false;
  //   });
  // }

  Future<http.Response> _performRequest({
    required RequestType requestType,
    required Uri uri,
    required Map<String, String> headers,
    Map<String, dynamic>? body,
    required int timeoutDuration,
  }) async {
    switch (requestType) {
      case RequestType.get:
        return await client.get(uri, headers: headers).timeout(Duration(seconds: timeoutDuration));
      case RequestType.post:
        return await client
            .post(uri, headers: headers, body: body != null ? jsonEncode(body) : null)
            .timeout(Duration(seconds: timeoutDuration));
      case RequestType.put:
        return await client
            .put(uri, headers: headers, body: body != null ? jsonEncode(body) : null)
            .timeout(Duration(seconds: timeoutDuration));
      case RequestType.patch:
        return await client
            .patch(uri, headers: headers, body: body != null ? jsonEncode(body) : null)
            .timeout(Duration(seconds: timeoutDuration));
      case RequestType.delete:
        return await client
            .delete(uri, headers: headers)
            .timeout(Duration(seconds: timeoutDuration));
    }
  }

  void _printDebugLogs({
    required String serviceName,
    required Uri uri,
    required Map<String, String> headers,
    required http.Response response,
    bool printUrl = true,
    bool printStatusCode = true,
    bool printResponseBody = false,
    bool printHeaders = false,
  }) {
    final timestamp = DateTime.now().toIso8601String();
    serviceName = serviceName.toUpperCase();
    kLog('[$timestamp] $serviceName Request Debugging:');
    if (printUrl) kLog('URL: $uri', emoji: '🔗');
    if (printStatusCode) {
      Logging().printStatusCode(serviceName, response.statusCode);
    }
    if (printHeaders) Logging().printHeaders(serviceName, headers);
    if (printResponseBody) {
      Logging().printResponseBody(serviceName, response.body);
    }
  }

  void _handleResponse({
    required String serviceName,
    required http.Response response,
    Function(dynamic)? onSuccess,
    Function(dynamic)? onError,
    Function(ErrorResponse)? onBadEntries400,
    Function(ErrorResponse)? onBadEntries422,
    Function(ErrorResponse)? onInvalidRequest401,
    Function(ErrorResponse)? onNotAuthorized403,
    Function(ErrorResponse)? onNotFound404,
    Function(ErrorResponse)? onAlreadyExist409,
    Function(ErrorResponse)? onNotAcceptable406,
    Function(dynamic)? onSuccessFullResponse,
  }) {
    final raw = response.body;
    final responseBody = raw.isNotEmpty ? _safeJsonDecode(raw) : null;

    kLog('raw');
    kLog(raw);
    kLog('responseBody');
    kLog(responseBody);

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccessFullResponse?.call(response);
        onSuccess?.call(responseBody);
        break;
      case 400:
        _handleError(response, onBadEntries400, serviceName);
        break;
      case 422:
        _handleError(response, onBadEntries422, serviceName);
        break;
      case 401:
        _handleError(response, onInvalidRequest401, serviceName);
        break;
      case 403:
        _handleError(response, onInvalidRequest401, serviceName);
        break;
      case 404:
        _handleError(response, onNotFound404, serviceName);
        break;
      case 409:
        _handleError(response, onAlreadyExist409, serviceName);
        break;
      case 406:
        _handleError(response, onNotAcceptable406, serviceName);
        break;
      default:
        showSnackBar('$serviceName: ${response.statusCode}', type: SnackBarType.failure);
    }
  }

  void _handleException(
    String serviceName,
    String errorMessage,
    Function(dynamic)? onException, {
    bool? showSnackBarWidget = true,
  }) {
    final timestamp = DateTime.now().toIso8601String();
    kLog('[$timestamp] $errorMessage');

    if (showSnackBarWidget == true && !_isFailureDialogVisible) {
      showSnackBar(errorMessage, type: SnackBarType.failure);
    }

    onException?.call(errorMessage);
  }

  void _handleError(http.Response response, Function(ErrorResponse)? callback, String serviceName) {
    dynamic decoded = _safeJsonDecode(response.body);

    final errorResponse = decoded is Map<String, dynamic>
        ? ErrorResponse.fromJson(decoded, response: response)
        : ErrorResponse(
            message: decoded.toString(),
            statusCode: response.statusCode,
            httpResponse: response,
          );

    callback?.call(errorResponse);
    Logging().printResponseBody(serviceName, response.body);
  }

  void _printCurlCommand(
    RequestType requestType,
    Uri uri,
    Map<String, String> headers,
    Map<String, dynamic>? body,
  ) {
    String curlCommand = "curl -X ${requestType.name.toUpperCase()} '${uri.toString()}'";
    headers.forEach((key, value) {
      curlCommand += " -H '$key: $value'";
    });
    if (body != null && body.isNotEmpty) {
      curlCommand += " -d '${jsonEncode(body)}'";
    }
    kLog("cURL Command: $curlCommand", emoji: '🚩🚩🚩🚩');
  }

  dynamic _safeJsonDecode(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return body; // returns the original body when it is not JSON
    }
  }
}

enum RequestType { get, post, put, patch, delete }

class ErrorResponse {
  final String? code; // from error.code
  final String? message; // extracted readable message
  final int? statusCode;
  final String? className;
  final http.Response? httpResponse;
  final List<String>? errors; // optional
  final dynamic rawError; // full raw error object before parsing

  ErrorResponse({
    this.code,
    this.message,
    this.statusCode,
    this.className,
    this.httpResponse,
    this.errors,
    this.rawError,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json, {http.Response? response}) {
    dynamic raw = json["error"];

    String? extractedCode;
    String? extractedMessage;
    List<String>? extractedErrors;

    if (raw is Map<String, dynamic>) {
      // handle error.code
      extractedCode = raw["code"]?.toString();

      // handle error.message (which may contain JSON string)
      final rawMessage = raw["message"];

      if (rawMessage is String) {
        // Try to decode inner JSON string
        try {
          final decodedInner = jsonDecode(rawMessage);

          // pick the important text message if exists
          extractedMessage =
              decodedInner["message"]?.toString() ??
              decodedInner["cause"]?["message"]?.toString() ??
              rawMessage;
        } catch (_) {
          // message is not JSON, use raw
          extractedMessage = rawMessage;
        }
      }
    }

    return ErrorResponse(
      code: extractedCode,
      message: extractedMessage,
      statusCode: json["statusCode"],
      className: json["className"],
      httpResponse: response,
      errors: extractedErrors,
      rawError: raw, // keep original error structure
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "message": message,
      "statusCode": statusCode,
      "className": className,
      "errors": errors,
      "rawError": rawError,
    };
  }
}

class ApiResponse<T> {
  dynamic message;
  T? data;
  int? statusCode;
  String? error;

  ApiResponse({this.message, this.data, this.error, this.statusCode});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
    statusCode = json['statusCode'];
    error = json['error'];
  }
}
