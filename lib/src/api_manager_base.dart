import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  String? _token;

  bool get isAuthenticated {
    return token != null;
  }

  String? get token {
    return _token;
  }

  Future login({
    required String url,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(Uri.parse(url), body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        _token = jsonDecode(response.body)['data']['token'];
      }
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future signUp({
    required String url,
    required Map<String, dynamic> body,
    required String password,
  }) async {
    try {
      final response = await http.post(Uri.parse(url), body: body);
      if (response.statusCode == 200) {
        _token = jsonDecode(response.body)['data']['token'];
      }
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future forgotPassword({
    required String url,
    required String email,
  }) async {
    try {
      final response = await http.post(Uri.parse(url), body: {"email": email});
      return response;
    } catch (err) {
      rethrow;
    }
  }

  Future otpVerification({
    required String url,
    required String email,
    required String otp,
  }) async {
    try {
      final response = await http.post(Uri.parse(url), body: {
        "email": email,
        "otp": otp,
      });
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future resetPassword({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await http.post(Uri.parse(url), body: body);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future googleSignUp() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      return googleSignInAccount;
    } catch (e) {
      rethrow;
    }
  }

  Future getMe({
    required String url,
    required Map<String, String> headers,
  }) async {
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
