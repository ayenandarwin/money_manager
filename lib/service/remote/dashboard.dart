import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:money_manager_app/model/dashboard.dart';
import 'package:money_manager_app/service/hive_service.dart';
import 'package:money_manager_app/utils/api.dart';

class DashboardService {
   Future<DashboardData> fetchDashboardData() async {
    final token = HiveCacheManager().getToken(); // Ensure token is fetched from Hive if needed

    if (token == null) {
      throw Exception('Token not found');
    }

    final url = Uri.parse('${APIURL.mainUrl}/dashboard');
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


