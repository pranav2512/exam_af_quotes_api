import 'dart:convert';

import 'package:exam_af_quotes_api/models/QuotesModel.dart';
import 'package:http/http.dart' as http;

class APIHelper {
  APIHelper._();

  List<Results> results=[];

  static final APIHelper apiHelper = APIHelper._();

  String api = "https://api.quotable.io/quotes?page=1&limit=60";


  Future<QuotesModel?> fetchQuote() async {
    http.Response response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      String data = response.body;
      Map<String, dynamic> decodedData = jsonDecode(data);
      return QuotesModel.fromJson(decodedData);
    }
    return null;
  }

  Future<List<Results>?> fetchQuoteById(Future<String?> id) async {
    String apiId ="https://api.quotable.io/quotes/$id";
    http.Response response = await http.get(Uri.parse(apiId));
    if (response.statusCode == 200) {
      String data = response.body;
      Map<String, dynamic> decodedData = jsonDecode(data);
      return results=results.map((e) => Results.fromJson(decodedData)).toList();
    }
    return null;
  }
}
