import 'dart:convert' show json, base64Url, utf8;

Map<String, dynamic>? parseJwt(String token) {
  // validate token
  if (token == null) return null;
  final List<String> parts = token.split('.');
  if (parts.length != 3) {
    return null;
  }
  // retrieve token payload
  final String payload = parts[1];
  final String normalized = base64Url.normalize(payload);
  final String resp = utf8.decode(base64Url.decode(normalized));
  // convert to Map
  final payloadMap = json.decode(resp);
  if (payloadMap is! Map<String, dynamic>) {
    return null;
  }
  return payloadMap;
}
