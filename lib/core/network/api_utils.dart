import 'dart:convert';
import 'dart:math';

import 'package:osoul_x_psm/core/logging/logging.dart';
import '../app/environment.dart';
import 'package:crypto/crypto.dart';

/// URLs and Headers
class ApiUtils {
  /// ///////////////////////////////////////////////////////////////////////////////////////////////////
  /// ////////////////////////////////////  URLs ////////////////////////////////////////////////
  /// ///////////////////////////////////////////////////////////////////////////////////////////////////

  final String _stagingServerURL =
      'https://9099462-sb1.restlets.api.netsuite.com/app/site/hosting/restlet.nl?deploy=1&script=';
  final String _productionServerURL =
      'https://9099462.restlets.api.netsuite.com/app/site/hosting/restlet.nl?deploy=1&script=';

  String getBaseURL() {
    if (kAppEnvironment is Staging) {
      return _stagingServerURL;
    } else if (kAppEnvironment is Production) {
      return _productionServerURL;
    } else {
      return '';
    }
  }

  /// ///////////////////////////////////////////////////////////////////////////////////////////////////
  /// ////////////////////////////////////  Headers  ////////////////////////////////////////////////////
  /// ///////////////////////////////////////////////////////////////////////////////////////////////////

  Map<String, String> headers({required Uri url, required String method}) {
    final oauth = OAuth1Helper(
      consumerKey: OAuthConfig.consumerKey,
      consumerSecret: OAuthConfig.consumerSecret,
      token: OAuthConfig.accessToken,
      tokenSecret: OAuthConfig.tokenSecret,
      realm: OAuthConfig.realm,
    );
    return {
      ...oauth.generateOAuthHeader(url: url.toString(), method: method.toUpperCase()),
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
}

class OAuthConfig {
  static const signatureMethod = 'HMAC-SHA256';
  static const version = '1.0';

  // Staging Configuration
  static const stagingConsumerKey =
      '091cd3f296f8811a57a3a804c33954ef6e0647e73b669b0a3885a8edf4914c75';
  static const stagingConsumerSecret =
      '57a8e6bf61c03aa773bec8d59b01dd801ba56a26c8e680a67f721f52254acfbb';
  static const stagingAccessToken =
      '4c499cbb8757dabd76b82afe1f33825c71bc1f5d009ae8c885d8a6c8dd9db702';
  static const stagingTokenSecret =
      'b1fcff8fb19e123678ce107703f061de9f184723c8337b4b84530f91e5fa63c3';
  static const stagingRealm = '9099462_SB1';

  // Production Configuration (TODO: Replace with actual production credentials)
  static const productionConsumerKey =
      '12f32070a65952328828dae2c98e60dcdd95d9a3805b891120d230d9bab786f1';
  static const productionConsumerSecret =
      '5f8fae23d70ef50947ebe076283f5befcf04b36d18238c398a21e567ad945d0b';
  static const productionAccessToken =
      '7739175be31aee9a9f1844ba3beccbfa2798e45a0fefc766be1aba66bc45898a';
  static const productionTokenSecret =
      'd7423eba80563b9f81390ed720a917cc36bbaf0ff2cbbee9ce6efd50a6aac0a7';
  static const productionRealm = '9099462';

  // Get current environment configuration
  static String get consumerKey =>
      kAppEnvironment is Production ? productionConsumerKey : stagingConsumerKey;
  static String get consumerSecret =>
      kAppEnvironment is Production ? productionConsumerSecret : stagingConsumerSecret;
  static String get accessToken =>
      kAppEnvironment is Production ? productionAccessToken : stagingAccessToken;
  static String get tokenSecret =>
      kAppEnvironment is Production ? productionTokenSecret : stagingTokenSecret;
  static String get realm => kAppEnvironment is Production ? productionRealm : stagingRealm;
}

class OAuth1Helper {
  final String consumerKey;
  final String consumerSecret;
  final String token;
  final String tokenSecret;
  final String realm;

  OAuth1Helper({
    required this.consumerKey,
    required this.consumerSecret,
    required this.token,
    required this.tokenSecret,
    required this.realm,
  });

  Map<String, String> generateOAuthHeader({
    required String url,
    required String method,
    Map<String, String>? extraParams,
  }) {
    final timestamp = _generateTimestamp();
    final nonce = _generateNonce();

    // OAuth parameters for signature (excluding realm)
    final oauthParams = {
      'oauth_consumer_key': consumerKey,
      'oauth_token': token,
      'oauth_signature_method': 'HMAC-SHA256',
      'oauth_timestamp': timestamp,
      'oauth_nonce': nonce,
      'oauth_version': '1.0',
    };

    // Combine with extra params if any
    final allParams = {...oauthParams, if (extraParams != null) ...extraParams};

    final signature = _generateSignature(url, method, allParams);

    // Build Authorization header in exact Postman format
    // Keys are NOT encoded, values ARE encoded
    final authHeader = [
      'realm="${Uri.encodeComponent(realm)}"',
      'oauth_consumer_key="${Uri.encodeComponent(consumerKey)}"',
      'oauth_token="${Uri.encodeComponent(token)}"',
      'oauth_signature_method="HMAC-SHA256"',
      'oauth_timestamp="$timestamp"',
      'oauth_nonce="$nonce"',
      'oauth_version="1.0"',
      'oauth_signature="${Uri.encodeComponent(signature)}"',
    ].join(','); // ✅ Comma without space, matching Postman

    return {'Authorization': 'OAuth $authHeader'};
  }

  String _generateSignature(String url, String method, Map<String, String> params) {
    // Parse URL to separate base URL and query parameters
    final uri = Uri.parse(url);
    final baseUrl = '${uri.scheme}://${uri.host}${uri.path}';

    // Combine OAuth params with query parameters from URL
    final allParams = <String, String>{
      ...params,
      ...uri.queryParameters, // ✅ Include query params in signature
    };

    // Sort parameters alphabetically
    final sortedKeys = allParams.keys.toList()..sort();

    // Build parameter string
    final paramString = sortedKeys
        .map((key) => '${Uri.encodeComponent(key)}=${Uri.encodeComponent(allParams[key]!)}')
        .join('&');

    // Build signature base string: METHOD&URL&PARAMS
    final baseString =
        '${method.toUpperCase()}&${Uri.encodeComponent(baseUrl)}&${Uri.encodeComponent(paramString)}';

    kLog('Base String: $baseString');

    // Build signing key: consumer_secret&token_secret
    final key = '${Uri.encodeComponent(consumerSecret)}&${Uri.encodeComponent(tokenSecret)}';

    kLog('Signing Key: $key');

    // Generate HMAC-SHA256 signature
    final hmacSha256 = Hmac(sha256, utf8.encode(key));
    final digest = hmacSha256.convert(utf8.encode(baseString));
    final signature = base64Encode(digest.bytes);

    kLog('HMAC-SHA256 Signature: $signature');

    return signature;
  }

  String _generateNonce() {
    // Nonce = Current Timestamp (in seconds) + 5 random digits
    final timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    final randomPart = Random.secure().nextInt(99999).toString().padLeft(5, '0');
    return '$timestamp$randomPart';
  }

  String _generateTimestamp() {
    return (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
  }
}
