import 'package:flutter/material.dart';

class PinDialog {
  static Future<bool> show(BuildContext context) async {
    final TextEditingController pinController = TextEditingController();

    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text("2FA Verification"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Masukkan PIN untuk melanjutkan pembayaran"),
                  const SizedBox(height: 10),
                  TextField(
                    controller: pinController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Enter PIN",
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (pinController.text == "123456") {
                      Navigator.pop(context, true);
                    } else {
                      Navigator.pop(context, false);
                    }
                  },
                  child: const Text("Verifikasi"),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}