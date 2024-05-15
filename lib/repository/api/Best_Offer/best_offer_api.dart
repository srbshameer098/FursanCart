import 'dart:convert';


import 'package:http/http.dart';



import '../../model_class/BestOffer/BestOfferModel.dart';
import '../api_client.dart';

class BestofferApi {
  ApiClient apiClient = ApiClient();
  String trendingPath = "/banner/all?type=OTHER";
  Future<List<BestOfferModel>> getBanner() async {
    Response response = await apiClient.invokeAPI(trendingPath, "GET",  null);

    return BestOfferModel.listFromJson(json.decode(response.body));
  }
}
