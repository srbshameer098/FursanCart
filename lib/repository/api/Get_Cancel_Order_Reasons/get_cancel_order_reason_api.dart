import 'dart:convert';
import 'package:http/http.dart';


import '../../model_class/CancelOrderReasons/CancelOrderReason.dart';

import '../api_client.dart';

class GetCancelOrderReasonApi {
  ApiClient apiClient = ApiClient();

  Future<List<CancelOrderReason>> getcancelorderreason() async {

    String trendingPath = "/product/order/cancel/reasons";
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);
    print(response.body);
    return CancelOrderReason.listFromJson(json.decode(response.body));
  }
}