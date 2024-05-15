import 'dart:convert';



import 'package:http/http.dart';
import '../../model_class/Product/ProductModel.dart';
import '../api_client.dart';

class SubCategorySelectedItemApi {
  ApiClient apiClient = ApiClient();

  Future<List<ProductModel>> getSubCategorySelectedItem({required String subcategoryid}) async {
    String trendingPath = '/product/all?subId=$subcategoryid';
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);

    return ProductModel.listFromJson(json.decode(response.body));
  }
}
