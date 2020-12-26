import 'dart:convert';
import 'package:appcenter_release_manager/appcenter_release_manager.dart';
import 'package:appcenter_release_manager/src/data/exception/appcenter_api_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Webservice {
  final String apiToken;

  Webservice({
    @required this.apiToken,
  });

  Future<T> get<T>(String url) async {
    final fullUrl = 'https://api.appcenter.ms$url';
    final result = await http.get(
      fullUrl,
      headers: {'X-API-Token': apiToken},
    );
    if (result.statusCode == 401) {
      throw AppCenterNoAccessApiError(
          'Make sure you have at least read access to `$fullUrl`');
    } else if (result.statusCode != 200) {
      throw AppCenterApiError(
          'Failed with ${result.statusCode} & body: ${result.body}');
    }
    return jsonDecode(result.body) as T;
  }
}
