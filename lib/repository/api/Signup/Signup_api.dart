import 'dart:convert';

import 'package:http/http.dart';


import '../../model_class/User/Usermodel.dart';
import '../api_client.dart';

class SignupApi {
  ApiClient apiClient = ApiClient();
  String trendingpath = '/auth/local/user/sign-up';

  Future<Usermodel> getuserdata(
      String email, String username, String password) async {
    var body = {"email": email, "username": username, "password": password};
    Response response = await apiClient.invokeAPI(trendingpath, 'POST', body);

    return Usermodel.fromJson(jsonDecode(response.body));
  }
}
