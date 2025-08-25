import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:money_manager_app/model/user.dart';
import 'package:money_manager_app/utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class UserService {
//   Future<UserModel> getUserProfile() async {

//     final url = Uri.parse("${APIURL.mainUrl}/me"); // Update URL
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       return UserModel.fromJson(jsonBody);
//     } else {
//       throw Exception('Failed to load user profile');
//     }
//   }
// }

class UserService {
  static Future<UserModel> fetchDashboardData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    final url = Uri.parse('http://128.199.81.208/api/v1/me');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // double check this
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return UserModel.fromJson(body);
    } else {
      debugPrint('User profile Response: ********  ${response.body}');
      throw Exception('Failed to load user profile: ${response.body}');
    }
  }
}
