import 'package:equatable/equatable.dart';

class NetworkRequest extends Equatable {
  final String endPoint;
  final Map<String, dynamic>? requestBody;
  final Map<String, dynamic>? queryParams;
  final Map<String, String>? headers;

  const NetworkRequest({
    required this.endPoint,
    this.requestBody,
    this.queryParams,
    this.headers,
  });

  @override
  List<Object?> get props => [
        endPoint,
        requestBody,
        queryParams,
        headers,
      ];
}
