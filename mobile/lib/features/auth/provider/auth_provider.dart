import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/auth_service.dart';
import '../../../core/api/backend_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final BackendService _backendService = BackendService();

  bool isLoading = false;
  String? jwtToken;

  // 🔐 LOGIN FLOW (Firebase → Backend JWT)
  Future<void> login(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      // 1. LOGIN FIREBASE
      await _authService.login(email, password);

      // 2. WAIT AUTH STATE UPDATE
      await Future.delayed(const Duration(seconds: 1));

      // 3. AMBIL USER
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("User tidak ditemukan setelah login");
      }

      // 4. AMBIL FIREBASE TOKEN (INI YANG BENAR)
      final firebaseToken = await user.getIdToken(true);

      print("🔥 FIREBASE TOKEN:");
      print(firebaseToken);

      // 5. KIRIM KE BACKEND → DAPAT JWT
      if (firebaseToken == null || firebaseToken.isEmpty) {
        throw Exception("Firebase token kosong");
      }

      jwtToken = await _backendService.loginToBackend(firebaseToken);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("jwt_token", jwtToken!);

      print("🔥 JWT TOKEN:");
      print(jwtToken);

    } catch (e) {
      print("❌ LOGIN ERROR: $e");
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // 🧾 REGISTER
  Future<void> register(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      await _authService.register(email, password);

    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // 🚪 LOGOUT
  Future<void> logout() async {
    await _authService.logout();
    jwtToken = null;
    notifyListeners();
  }

  // 🔑 DEBUG TOKEN (MANUAL TEST)
  Future<String?> getFirebaseTokenDebug() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("User belum login");
    }

    final token = await user.getIdToken(true);

    print("🔥 FIREBASE ID TOKEN:");
    print(token);

    return token;
  }
}