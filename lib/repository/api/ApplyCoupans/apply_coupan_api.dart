import 'dart:convert';

import 'package:http/http.dart';



import '../../model_class/Coupan/CouponModel.dart';
import '../api_client.dart';

class ApplyCoupanApi {
  ApiClient apiClient = ApiClient();

  Future<List<CouponModel>> applycoupan({
    required String code,
  }) async {

    String trendingPath = "/coupons/all?code=$code";


    Response response =
    await apiClient.invokeAPI(trendingPath, "GET", null);
    print(response.body);
    return CouponModel.listFromJson(json.decode(response.body));
}}
