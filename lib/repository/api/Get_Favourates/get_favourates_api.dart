import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model_class/GetFavourates/GetFavouratesModel.dart';
import '../api_client.dart';

class GetFavouratesApi {
  ApiClient apiClient = ApiClient();

  Future<GetFavouratesModel> getfavourates() async {
    final preferences=await SharedPreferences.getInstance();
    final userid=preferences.getString('UserId');
    String trendingPath = "/product/wishlist/get?userId=$userid";
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);
    print(response.body);
    return GetFavouratesModel.fromJson(json.decode(response.body));
  }
}
