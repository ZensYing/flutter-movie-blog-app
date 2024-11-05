// lib/services/directus_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:movie_app/providers/user_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
// ignore: depend_on_referenced_packages
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DirectusService {
  final String baseUrl = "https://sounsoratha.online/cms";

  Future<String?> login(
      String email, String password, UserProvider userProvider) async {
    final url = Uri.parse("$baseUrl/auth/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['data']['access_token'];

      // Save token in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      return token; // Return JWT token
    } else {
      if (kDebugMode) {
        print("Login failed with status code: ${response.statusCode}");
      }
      if (kDebugMode) {
        print("Response body: ${response.body}");
      }
      return null;
    }
  }

  Future<bool> register(String email, String password, String name) async {
    final url = Uri.parse("$baseUrl/users");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "email": email,
        "password": password,
        "first_name": name,
        "status": "active",
      }),
    );

    return response.statusCode == 200;
  }

  Future<bool> updateUserProfile({
    required String name,
    required String email,
    String? password,
    File? avatarFile,
  }) async {
    // Fetch the token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      if (kDebugMode) {
        print("Error: No auth token found. User might not be logged in.");
      }
      return false;
    }

    final url = Uri.parse("$baseUrl/users/me");

    Map<String, dynamic> data = {
      "first_name": name,
      "email": email,
    };

    if (password != null && password.isNotEmpty) {
      data["password"] = password;
    }

    if (avatarFile != null) {
      final avatarId = await _uploadFile(avatarFile);
      if (avatarId != null) {
        data["avatar"] = avatarId;
      }
    }

    final response = await http.patch(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("Profile updated successfully.");
      }
      return true;
    } else {
      if (kDebugMode) {
        print(
            "Failed to update profile with status code: ${response.statusCode}");
      }
      if (kDebugMode) {
        print("Response body: ${response.body}");
      }
      return false;
    }
  }

  Future<String?> _uploadFile(File file) async {
    final url = Uri.parse("$baseUrl/files");
    final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';

    final request = http.MultipartRequest("POST", url)
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: MediaType.parse(mimeType),
        filename: basename(file.path),
      ));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final jsonData = json.decode(responseData);
      return jsonData['data']['id'];
    } else {
      if (kDebugMode) {
        print("File upload failed: ${response.statusCode}");
      }
      return null;
    }
  }
}
