import 'package:flutter/material.dart';
import '../data/auth_service.dart';
import '../../../core/api/backend_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final BackendService _backendService = BackendService();

  bool isLoading = false;
  String? jwtToken;

  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    final user = await _authService.login(email, password);

    final firebaseToken = await _authService.getFirebaseToken();

    jwtToken = await _backendService.loginToBackend(firebaseToken!);

    isLoading = false;
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    isLoading = true;
    notifyListeners();

    await _authService.register(email, password);

    isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    jwtToken = null;
    notifyListeners();
  }
}