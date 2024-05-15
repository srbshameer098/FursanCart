import 'dart:convert';



import 'package:http/http.dart';
import '../../model_class/Subcategory/SubCategoryModel.dart';
import '../api_client.dart';

class SubCategoryPageApi {
  ApiClient apiClient = ApiClient();

  Future<List<SubCategoryModel>> getSubCategory({required String categoryId}) async {
    String trendingPath = "/sub-category/all?catId=$categoryId";
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);

    return SubCategoryModel.listFromJson(json.decode(response.body));
  }
}
