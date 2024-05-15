import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model_class/UpdatePassword/UpdatePasswordModel.dart';
import '../api_client.dart';

class UpdatePasswordApi {
  ApiClient apiClient = ApiClient();

  Future<UpdatePasswordModel> updatepassword({required String oldPassword,required String newPassword}) async {
    final preferences=await SharedPreferences.getInstance();
    final userid=preferences.getString('UserId');
    String trendingPath = "/user/reset-password/$userid";
    var body ={
      "oldPass":oldPassword,
      "newPass":newPassword
    };

    print(jsonEncode(body));
    Response response = await apiClient.invokeAPI(trendingPath, "PATCH",  jsonEncode(body));
    print(response.body);
    return UpdatePasswordModel.fromJson(json.decode(response.body));
  }
}
