import 'dart:convert';


import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model_class/Product/ProductModel.dart';
import '../api_client.dart';

class TrendingNowApi {
  ApiClient apiClient = ApiClient();

  Future<List<ProductModel>> gettrendingnow() async {
    final preferences=await SharedPreferences.getInstance();
    final userid=preferences.getString('UserId');
    String trendingPath = "/product/all?tag=trending&userId=$userid";
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);

    return ProductModel.listFromJson(json.decode(response.body));
  }
}
