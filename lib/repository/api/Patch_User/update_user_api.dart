import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model_class/UpdateUser/UpdateUserModel.dart';
import '../multi_patch_method_api_client.dart';

class UpdateUserApi {
  PatchMethodApiClient apiClient = PatchMethodApiClient();

  Future<UpdateUserModel> updateusername({required String username}
  ) async {
    final preferences = await SharedPreferences.getInstance();
    final updateuserId = preferences.getString('UserId');
    String trendingpath = '/user/update/$updateuserId';
    var body = {
      'username': username,
    };
    print(jsonEncode(body));
    Response response = await apiClient.invokeApi(
        filepath: [], Path: trendingpath, method: 'PATCH', body: body);
    print(response.body);
    return UpdateUserModel.fromJson(jsonDecode(response.body));
  }
  Future<UpdateUserModel> updateemail({required String email}
      ) async {
    final preferences = await SharedPreferences.getInstance();
    final updateuserId = preferences.getString('UserId');
    String trendingpath = '/user/update/$updateuserId';
    var body = {
      'email': email,
    };
    print(jsonEncode(body));
    Response response = await apiClient.invokeApi(
        filepath: [], Path: trendingpath, method: 'PATCH', body: body);
    print(response.body);
    return UpdateUserModel.fromJson(jsonDecode(response.body));
  }
  Future<UpdateUserModel> updatephone({required String phone}
      ) async {
    final preferences = await SharedPreferences.getInstance();
    final updateuserId = preferences.getString('UserId');
    String trendingpath = '/user/update/$updateuserId';
    var body = {
      'phone': phone,
    };
    print(jsonEncode(body));
    Response response = await apiClient.invokeApi(
        filepath: [], Path: trendingpath, method: 'PATCH', body: body);
    print(response.body);
    return UpdateUserModel.fromJson(jsonDecode(response.body));
  }


}
