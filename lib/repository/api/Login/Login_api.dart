import 'dart:convert';


import 'package:http/http.dart';
import '../../model_class/User/Usermodel.dart';
import '../api_client.dart';

class LoginApi {
  ApiClient apiClient = ApiClient();
  String trendingpath = '/auth/local/user/login';

  Future<Usermodel> postuserdata(String email, String password) async {
    var body = {'email': email, 'password': password};
    Response response = await apiClient.invokeAPI(trendingpath, 'POST', body);

    return Usermodel.fromJson(jsonDecode(response.body));
  }
}