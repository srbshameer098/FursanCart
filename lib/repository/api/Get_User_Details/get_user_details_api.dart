import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model_class/GetUserDetails/GetUserDetailsModel.dart';
import '../api_client.dart';

class GetUserDetailsApi {
  ApiClient apiClient = ApiClient();

  Future<GetUserDetailsModel> getuserdetails() async {
    final preferences=await SharedPreferences.getInstance();
    final userid=preferences.getString('UserId');
    String trendingPath = "/user/$userid";
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);
    print(response.body);
    return GetUserDetailsModel.fromJson(json.decode(response.body));
  }
}
