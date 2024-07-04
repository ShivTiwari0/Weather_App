import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkUtilties {
 static Future<String?> frtchurl(Uri uri, {Map<String, String>? hedars}) async {
    try {
      final response = await http.get(uri, headers: hedars);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
