// File: lib/services/auth_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _refreshTokenUrl = "http://localhost:5274/refresh"; // Replace with your actual refresh endpoint

  // Save tokens securely
  static Future<void> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
  }

   Future<bool> isAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email'); // Retrieve the stored email
    const adminEmail = 'admin@example.com'; // Replace with your admin email
    return email == adminEmail; // Check if the email matches the admin email
  }

  // Get tokens
  static Future<Map<String, String?>> getTokens() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'accessToken': prefs.getString('accessToken'),
      'refreshToken': prefs.getString('refreshToken'),
    };
  }

  // Refresh token method
  static Future<bool> refreshAccessToken() async {
    final tokens = await getTokens();
    final refreshToken = tokens['refreshToken'];

    if (refreshToken == null) {
      return false; // No refresh token available
    }

    final response = await http.post(
      Uri.parse(_refreshTokenUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "refreshToken": refreshToken,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['accessToken'];
      final newRefreshToken = data['refreshToken'];

      // Save the new tokens
      await saveTokens(newAccessToken, newRefreshToken);
      return true;
    } else {
      return false; // Refresh failed
    }
  }

  // Example API call with token refresh
  static Future<http.Response> makeAuthenticatedRequest(String url, {Map<String, String>? headers}) async {
    final tokens = await getTokens();
    String? accessToken = tokens['accessToken'];

    if (accessToken == null) {
      throw Exception("No access token available");
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $accessToken",
        ...?headers,
      },
    );

    if (response.statusCode == 401) {
      // Token expired, try refreshing
      final refreshed = await refreshAccessToken();
      if (refreshed) {
        // Retry the request with the new access token
        final newTokens = await getTokens();
        accessToken = newTokens['accessToken'];

        return http.get(
          Uri.parse(url),
          headers: {
            "Authorization": "Bearer $accessToken",
            ...?headers,
          },
        );
      } else {
        throw Exception("Unable to refresh token");
      }
    }

    return response;
  }
}