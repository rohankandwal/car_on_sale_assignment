import 'package:assignment_car_on_sale/core/network/network_request.dart';
import 'package:assignment_car_on_sale/feature/home/data/model/vehicle_search_model.dart';

sealed class RestClient {
  /// 'POST' request
  Future<VehicleSearchModel> post(
    final NetworkRequest request,
  );
}

class RestClientImpl extends RestClient {
  @override
  Future<VehicleSearchModel> post(final NetworkRequest request) {
    // TODO: implement post
    throw UnimplementedError();
  }
}
