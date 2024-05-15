import 'dart:convert';
import 'package:http/http.dart';
import '../../model_class/GetDeliveryType/GetDeliveryTypeModel.dart';
import '../api_client.dart';

class GetDeliveryTypesApi {
  ApiClient apiClient = ApiClient();

  Future<List<GetDeliveryTypeModel>> getalldeliverytype() async {
    String trendingPath = "/admin/delivery-type/all";
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);
    print(response.body);
    return GetDeliveryTypeModel.listFromJson(json.decode(response.body));
  }
}