import 'dart:convert';

import 'package:untitled1/screens/DataModel.dart';
import 'package:http/http.dart' as http;

Future<ApiDataModel> getUserData() async {
  List<ApiDataModel> liveContestModel;
  String url = 'https://api.exchangerate-api.com/v4/latest/USD';
  Uri baseUri = Uri.parse(url);
  final http.Response response = await http.get(
    baseUri,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
  );

  print(response.statusCode);

  try {
    if (response.statusCode == 200) {
      return ApiDataModel.fromJson(jsonDecode(response.body));
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}
