import 'dart:convert';

import 'package:http/http.dart';
import '../../model_class/RemoveCart/remove_cart_model.dart';
import '../api_client.dart';

class RemoveCartApi {
  ApiClient apiClient = ApiClient();

  Future<RemoveCartModel> removecart({required String cartproductid,
  }) async {

    String trendingPath = "/product/remove-from-cart/$cartproductid";

    Response response = await apiClient.invokeAPI(trendingPath, "DELETE",  null);
    print(response.body);
    return RemoveCartModel.fromJson(json.decode(response.body));
  }
}
