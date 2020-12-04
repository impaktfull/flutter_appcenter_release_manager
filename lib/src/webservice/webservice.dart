import 'dart:convert';
import 'package:appcenter_release_manager/src/data/exception/appcenter_api_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Webservice {
  final String apiToken;

  Webservice({
    @required this.apiToken,
  });

  Future<T> get<T>(String url) async {
    final result = await http.get(
      'https://api.appcenter.ms$url',
      headers: {'X-API-Token': apiToken},
    );
    if (result.statusCode != 200) {
      throw AppCenterApiError('Failed with ${result.statusCode} & body: ${result.body}');
    }
    return jsonDecode(result.body) as T;
  }
}
