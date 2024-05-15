import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model_class/CancelOrder/CancelOrder.dart';
import '../api_client.dart';

class CancelOrderApi {
  ApiClient apiClient = ApiClient();

  Future<CancelOrder> cancelOrder({required String orderId,required String reason}) async {
    final preferences=await SharedPreferences.getInstance();
    final userid=preferences.getString('UserId');
    String trendingPath = "/product/orders/cancel/$orderId";
  var body={
  "userId":userid,
  "reason":reason,
 };
    Response response = await apiClient.invokeAPI(trendingPath, "PATCH1", body);
    print(response.body);
    return CancelOrder.fromJson(json.decode(response.body));
  }
}
