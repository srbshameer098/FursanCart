import 'dart:convert';


import 'package:http/http.dart';



import '../../model_class/Brand/BrandModel.dart';
import '../api_client.dart';

class ChooseBrandApi {
  ApiClient apiClient = ApiClient();
  String trendingPath = "/brand/all";
  Future<List<BrandModel>> getBrand() async {
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);

    return BrandModel.listFromJson(json.decode(response.body));
  }
}
