import 'dart:convert';
import 'package:http/http.dart';
import '../../model_class/SearchProduct/SearchProductModel.dart';
import '../api_client.dart';

class SearchProductApi {
  ApiClient apiClient = ApiClient();

  Future<List<SearchProductModel>> searchproduct({required String keyword}) async {
    String trendingPath = "/product/search?s=$keyword";
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);
    print(response.body);
    return SearchProductModel.listFromJson(json.decode(response.body));
  }
}
