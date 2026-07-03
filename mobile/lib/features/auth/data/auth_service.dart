import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> register(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await result.user!.sendEmailVerification();

    return result.user;
  }

  Future<User?> login(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (!result.user!.emailVerified) {
      await _auth.signOut();
      throw Exception("Email belum diverifikasi");
    }

    return result.user;
  }

  Future<String?> getFirebaseToken() async {
    final user = _auth.currentUser;
    return await user?.getIdToken();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}