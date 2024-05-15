import 'dart:convert';



import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model_class/Product/ProductModel.dart';
import '../api_client.dart';

class SelectedBestofferApi {
  ApiClient apiClient = ApiClient();

  Future<List<ProductModel>> getselectedbanner(String bannersubid) async {
    final preferences=await SharedPreferences.getInstance();
    final userid=preferences.getString('UserId');
    String trendingPath = "/product/all?tag=bestOffers&subId=$bannersubid&userId=$userid";
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);

    return ProductModel.listFromJson(json.decode(response.body));
  }
}
