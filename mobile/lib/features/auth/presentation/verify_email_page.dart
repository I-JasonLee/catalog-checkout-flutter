import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    user?.sendEmailVerification();
  }

  Future<void> checkEmailVerified() async {
    await user?.reload();
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text("Login Success")),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Cek email kamu untuk verifikasi"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkEmailVerified,
              child: const Text("Saya sudah verifikasi"),
            ),
          ],
        ),
      ),
    );
  }
}