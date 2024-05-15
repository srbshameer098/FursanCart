import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model_class/PostAddress/PostAddressModel.dart';
import '../api_client.dart';

class PostAddressApi {
  ApiClient apiClient = ApiClient();

  Future<PostAddressModel> postadress(
      {required String state,
        required String type,
        required String fullname,
        required String houseNoOrBuildingName,
        required String landmark,
        required String phonenumber,
        required int pincode,
        required String city}) async {
    final preferences = await SharedPreferences.getInstance();
    final userid = preferences.getString('UserId');
    String trendingPath = "/user/add-delivery-address";
    var body = {
      "userId": userid,
      "fullName": fullname,
      "type": type,
      "phone": phonenumber,
      "state": state,
      "city": city,
      "pincode": pincode,
      "houseNoOrBuildingName": houseNoOrBuildingName,
      "landmark": landmark,
      "address": "fsdyughfsfkjdsuifhdsfdkljgrr"
    };

    print(jsonEncode(body));
    Response response = await apiClient.invokeAPI(
      trendingPath,
      "POST_",
      jsonEncode(body),
    );
    print(response.body);
    return PostAddressModel.fromJson(json.decode(response.body));
  }
}
