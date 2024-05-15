import 'dart:convert';



import 'package:fursan_cart/repository/model_class/PostFavourates/PostFavouratesModel.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_client.dart';

class AddToFavouritesApi {
  ApiClient apiClient = ApiClient();

  Future<PostFavouratesModel> addtofavourites({required String productid}) async {
    final preferences=await SharedPreferences.getInstance();
    final userid=preferences.getString('UserId');
    String trendingPath = "/product/wishlist/add";
    var body=
      {
        "varientId": productid,
        "userId": userid
      };
    print(jsonEncode(body));
    Response response = await apiClient.invokeAPI(trendingPath, "POST_",  jsonEncode(body));

    return PostFavouratesModel.fromJson(json.decode(response.body));
  }
}
