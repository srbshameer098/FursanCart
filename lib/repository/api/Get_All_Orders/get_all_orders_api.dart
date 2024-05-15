import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model_class/GetAllOrders/GetAllOrders.dart';
import '../api_client.dart';

class GetAllOrdersApi {
  ApiClient apiClient = ApiClient();

  Future<List<GetAllOrders>> getallorders() async {
    final preferences=await SharedPreferences.getInstance();
    final  userId= preferences.getString('UserId');
    String trendingPath = "/product/orders/all?userId=$userId";
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);
    print(response.body);
    return GetAllOrders.listFromJson(json.decode(response.body));
  }
}