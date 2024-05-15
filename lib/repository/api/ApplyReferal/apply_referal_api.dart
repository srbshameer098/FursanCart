import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../../model_class/Referral/Referral.dart';
import '../api_client.dart';

class ApplyReferalApi {
  ApiClient apiClient = ApiClient();

  Future<Referral> applyreferal({
    required String referalCode,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final userid = preferences.getString('UserId');
    String trendingPath = "/referrals/apply-code";
    var body = {'referralCode': referalCode,'userId': userid};

    print(jsonEncode(body));
    Response response =
    await apiClient.invokeAPI(trendingPath, "POST_", jsonEncode(body));
    print(response.body);
    return Referral.fromJson(json.decode(response.body));
  }
}
