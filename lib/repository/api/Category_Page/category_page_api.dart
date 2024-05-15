import 'dart:convert';



import 'package:http/http.dart';
import '../../model_class/Category/CategoryModel.dart';
import '../api_client.dart';

class CategoryPageApi {
  ApiClient apiClient = ApiClient();
  String trendingPath = "/category/all";
  Future<List<CategoryModel>> getCategory() async {
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);

    return CategoryModel.listFromJson(json.decode(response.body));
  }
}
