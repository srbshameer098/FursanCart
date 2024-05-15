import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model_class/Product/ProductModel.dart';
import '../api_client.dart';

class SelectedBrandApi {
  ApiClient apiClient = ApiClient();

  late final String brandid;
  Future<List<ProductModel>> selectedbrand( brandid) async {
    final preferences=await SharedPreferences.getInstance();
    final userid=preferences.getString('UserId');
    String trendingpath = '/product/all?brandId=$brandid&userId=$userid';
    Response response = await apiClient.invokeAPI(trendingpath, 'GET', null);

    return ProductModel.listFromJson(jsonDecode(response.body));
  }
}