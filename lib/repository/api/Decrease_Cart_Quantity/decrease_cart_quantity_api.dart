import 'dart:convert';
import 'package:http/http.dart';
import '../../model_class/DecreaseCartQuantity/DecreaseCartQuantityModel.dart';
import '../api_client.dart';

class DecreaseCartQuantityApi {
  ApiClient apiClient = ApiClient();

  Future<DecreaseCartQuantityModel> decreasecartquantity({required String cartproductid,required int quantity
  }) async {
    String trendingPath = "/product/decrease-cart-quantity";
    var body=
      {
        "cartItemId":cartproductid.toString(),
        "quantity":quantity
      };
    Response response = await apiClient.invokeAPI(trendingPath, "DELETE",body);
    print(response.body);

    print(response.body);
    return DecreaseCartQuantityModel.fromJson(json.decode(response.body));
  }
}
