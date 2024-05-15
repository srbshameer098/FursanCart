import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model_class/PostCart/PostCartModel.dart';
import '../api_client.dart';

class AddToCartApi {
  ApiClient apiClient = ApiClient();

  Future<PostCartModel> addtocart({required String varientid,required int quantity
  }) async {
    final preferences=await SharedPreferences.getInstance();
    final userid=preferences.getString('UserId');
    String trendingPath = "/product/add-to-cart";
    var body =
      {
        "userId": userid,
        "varientId": varientid,
        "quantity": quantity
      };


    print(jsonEncode(body));
    Response response = await apiClient.invokeAPI(trendingPath, "POST_",  jsonEncode(body));
  print(response.body);
    return PostCartModel.fromJson(json.decode(response.body));
  }
}
