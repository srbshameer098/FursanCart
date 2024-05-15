import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model_class/GetCart/GetCartModel.dart';
import '../api_client.dart';

class GetCartApi {
  ApiClient apiClient = ApiClient();

  Future<GetCartModel> getcart() async {
    final preferences=await SharedPreferences.getInstance();
    final userid=preferences.getString('UserId');
    String trendingPath = "/product/cart/$userid";
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);
    print(response.body);
    return GetCartModel.fromJson(json.decode(response.body));
  }
}
