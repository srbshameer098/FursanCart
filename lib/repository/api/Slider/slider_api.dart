import 'dart:convert';


import 'package:http/http.dart';




import '../../model_class/SliderModel/SliderModel.dart';
import '../api_client.dart';

class SliderApi {
  ApiClient apiClient = ApiClient();
  String trendingPath = "/banner/all?type=SLIDER";
  Future<List<SliderModel>> getBanner() async {
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);
print(response.body);
    return SliderModel.listFromJson(json.decode(response.body));
  }
}
