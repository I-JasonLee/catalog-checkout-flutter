class BackendService {
  Future<String> loginToBackend(String firebaseToken) async {
    // simulasi backend verify Firebase token
    await Future.delayed(const Duration(seconds: 1));

    // backend return JWT
    return "JWT_TOKEN_DUMMY_123456";
  }
}