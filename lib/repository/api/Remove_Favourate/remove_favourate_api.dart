import 'dart:convert';
import 'package:http/http.dart';
import '../../model_class/RemoveFavourate/RemoveFavourateModel.dart';
import '../api_client.dart';

class RemoveFavourateApi {
  ApiClient apiClient = ApiClient();

  Future<RemoveFavourateModel> removefavourate({required String productwhislistid,
  }) async {

    String trendingPath = "/product/wishlist/delete/$productwhislistid";

    Response response = await apiClient.invokeAPI(trendingPath, "DELETE",  null);
    print(response.body);
    return RemoveFavourateModel.fromJson(json.decode(response.body));
  }
}
