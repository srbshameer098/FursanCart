import 'dart:convert';


import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';




import '../../model_class/SelectedProductModel/SelectedProductModel.dart';
import '../api_client.dart';

class SelectedProductApi {
  ApiClient apiClient = ApiClient();

  Future<SelectedProductModel> getselectedproduct(String productid) async {
    final preferences=await SharedPreferences.getInstance();
    final  userId= preferences.getString('UserId');
    String trendingPath = "/product/$productid";
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);

    return SelectedProductModel.fromJson(jsonDecode(response.body));
  }
}
