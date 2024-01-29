
abstract class Api {
  static const baseUrl = "http://localhost:8000";

  static Map<String, dynamic> headers(String? accessToken) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
  }
}
