import 'package:url_launcher/url_launcher.dart';

class CallbackService {
  Future<void> sendResult({
    required String transactionId,
    required int amount,
    required bool success,
  }) async {

    final uri = Uri(
      scheme: "merchant",
      host: "payment-result",
      queryParameters: {
        "transactionId": transactionId,
        "amount": amount.toString(),
        "status": success ? "success" : "failed",
      },
    );

    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      print("Gagal mengirim callback ke Merchant");
    } else {
      print("Callback berhasil dikirim");
    }
  }
}