import 'dart:convert';

import 'package:http/http.dart';
import '../../model_class/RemoveAddress/RemoveAddressModel.dart';
import '../api_client.dart';

class RemoveAddressApi {
  ApiClient apiClient = ApiClient();

  Future<RemoveAddressModel> removeaddress({required String addressid,
  }) async {

    String trendingPath = "/user/delivery-address/delete/$addressid";

    Response response = await apiClient.invokeAPI(trendingPath, "DELETE",  null);
    print(response.body);
    return RemoveAddressModel.fromJson(json.decode(response.body));
  }
}
