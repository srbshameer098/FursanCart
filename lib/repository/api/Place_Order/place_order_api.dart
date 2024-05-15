import 'dart:convert';




import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model_class/PlaceOrder/PlaceOrderModel.dart';
import '../api_client.dart';

class PlaceOrderApi {
  ApiClient apiClient = ApiClient();

  Future<PlaceOrderModel> placeorder({required List<Map<String, dynamic>> listOfCartItemId2 ,required String deliveryId,required String paymentMethod,required String coupan,required String deliveryTypeId}) async {
    final preferences=await SharedPreferences.getInstance();
    final userid=preferences.getString('UserId');
    String trendingPath = "/product/place-order";
    var body={
      "custId": userid,
      "fromCart": true,
      "dlvryId":deliveryId,
      "paymentType":paymentMethod,
      "paymentProvider":"None",
      "deliveryTypeId":deliveryTypeId,
      "code":coupan,
      "items": listOfCartItemId2
    };
    print(jsonEncode(body));
    Response response = await apiClient.invokeAPI(trendingPath, "POST_",  jsonEncode(body));
print(response.body);
    return PlaceOrderModel.fromJson(json.decode(response.body));
  }
}

