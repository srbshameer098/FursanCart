import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
class PatchMethodApiClient {
  static  String basepath1 =basePath;

  Future<http.Response> invokeApi({
    required List<XFile>? filepath,
    required String Path,
    required String method,
    required Map<String, String>? body,
    bool isFiles = true,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('Token');
    Map<String, String> headerParams = {"authorization": "Bearer $token"};

    print(basepath1 + Path);
    var request = http.MultipartRequest(method, Uri.parse(basepath1 + Path));
    request.headers.addAll(headerParams);
    print(basepath1 + Path);
    print("request : $basepath1$Path");
    List<http.MultipartFile> newList = [];
    if (filepath != null) {
      for (int i = 0; filepath.length > i; i++) {
        if (filepath[i].path != "") {
          request.files.add(await http.MultipartFile.fromPath(
              isFiles ? 'files' : 'file', filepath[i].path.toString()));

          // var multipartFile = await http.MultipartFile.fromPath(
          //     "files", filepath[i].path.toString());
          // print(filepath[i].path.toString());
          // print(multipartFile.field);
          // newList.add(multipartFile);
        }
      }
    }

    print(body);
    print("111111111111111111111111111111111111111111111111111111111");
    body != null ? request.fields.addAll(body) : null;
    print(request);

    http.StreamedResponse res = await request.send();
    print(res);
    http.Response responsed = await http.Response.fromStream(res);
    print(responsed);
    print(responsed.body);
    final responseData = json.decode(responsed.body);

    print('worked 4');
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(responseData);
    } else {
      print('Error');
    }
    print("reason : $res.");
    print(responsed);
    return responsed;
  }
}
