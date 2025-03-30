import 'package:assignment_car_on_sale/core/network/network_request.dart';
import 'package:assignment_car_on_sale/feature/login/data/models/user_model.dart';

abstract class RestClient {
  /// 'POST' request
  Future<UserModel> post(
    final NetworkRequest request,
  );
}

class RestClientImpl extends RestClient {
  @override
  Future<UserModel> post(
    final NetworkRequest request,
  ) {
    throw UnimplementedError();
  }
}
