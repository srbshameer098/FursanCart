import 'dart:convert';


import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model_class/PlaceOrder/PlaceOrderModel.dart';
import '../api_client.dart';

class BuyNowPlaceOrderApi {
  ApiClient apiClient = ApiClient();

  Future<PlaceOrderModel> buynowplaceorder(
      {required String totalAmount,required String paymentType,required String deliveryTypeId,required String coupanCode,
      required String deliveryId,
      required String productId,
      required int quantity}) async {
    final preferences = await SharedPreferences.getInstance();
    final userid = preferences.getString('UserId');
    String trendingPath = "/product/place-order";
    var body = {
    "custId": userid,
    "fromCart": false,
    "dlvryId":deliveryId,
    "paymentType":paymentType,
    "paymentProvider":"None",
    "deliveryTypeId":deliveryTypeId,
    "code":coupanCode,
      "items": [
        {
          "productId": productId,
          "quantity": quantity
        }
      ]
    };

    print(jsonEncode(body));
    Response response =
        await apiClient.invokeAPI(trendingPath, "POST_", jsonEncode(body));
    print(response.body);

    return PlaceOrderModel.fromJson(json.decode(response.body));
  }
}
