import 'package:http/http.dart' as http;

class RequestAdapterService extends http.BaseClient {
  late final http.Client client = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers["accept"] = "application/json";
    return client.send(request);
  }

  /// Parse Uri from string
  Uri parseUri(String url) {
    return Uri.parse(url);
  }

  /// GET request
  requestGet(String url) async {
    return await client.get(parseUri(url));
  }

  /// POST request
  requestPost(String url, dynamic body) async {
    return await client.post(parseUri(url), body: body);
  }
}