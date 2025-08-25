import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:money_manager_app/model/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardService {
  static Future<DashboardData> fetchDashboardData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    final url = Uri.parse('http://128.199.81.208/api/v1/dashboard');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // double check this
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return DashboardData.fromJson(body['data']);
    } else {
      debugPrint('Response: ${response.body}');
      throw Exception('Failed to load dashboard data: ${response.body}');
    }
  }
}


