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