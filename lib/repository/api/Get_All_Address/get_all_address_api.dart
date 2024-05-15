import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model_class/GetAllAddress/GetAllAddressModel.dart';
import '../api_client.dart';

class GetAllAddressApi {
  ApiClient apiClient = ApiClient();

  Future<List<GetAllAddressModel>> getalladdress() async {
    final preferences=await SharedPreferences.getInstance();
    final userid=preferences.getString('UserId');
    String trendingPath = "/user/delivery-address/all?userId=$userid";
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);
    print(response.body);
    return GetAllAddressModel.listFromJson(json.decode(response.body));
  }
}