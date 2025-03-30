import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:http/testing.dart';

class HttpAuthenticationHandler {
  HttpAuthenticationHandler._();

  static final BaseClient mockAuthClient = MockClient((request) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    if (request.url.path == '/v1/login' && request.method == 'POST') {
      final matched = Random().nextBool();
      if (matched) {
        return Response(
            jsonEncode({
              'token': 'mockToken',
              'name': 'Mock Authenticated User',
            }),
            200);
      }
      return Response(jsonEncode({'error': 'Incorrect credentials'}), 401);
    }

    return Response(jsonEncode({'error': 'Unknown endpoint'}), 404);
  });
}
