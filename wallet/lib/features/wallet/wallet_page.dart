import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/wallet_provider.dart';
import '../../services/deeplink_service.dart';
import 'set_pin_page.dart';
import 'services/pin_service.dart';
import 'services/payment_service.dart';
import 'services/callback_service.dart';
import 'transaction_history_page.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});
    @override
  State<WalletPage> createState() => _WalletPageState();
}
class _WalletPageState extends State<WalletPage> {
  final DeeplinkService _deeplinkService = DeeplinkService();
    @override
  void initState() {
    super.initState();
    _deeplinkService.init((uri){
      if(uri.scheme == "wallet" && uri.host == "payment"){
        final amount = int.parse(
          uri.queryParameters["amount"] ?? "0",
        );
        final transactionId = uri.queryParameters["transactionId"] ?? "-";
        final token = uri.queryParameters["token"];
        final walletProvider = Provider.of<WalletProvider>(
          context, listen:false,
        );
        walletProvider.setTransaction(
          transactionId: transactionId, amount: amount,
        );
        if(token != null){
          print("🔥 TOKEN DARI MERCHANT:");
          print(token);
          walletProvider.setToken(token);
        }
        else{
          print("❌ TOKEN TIDAK DIKIRIM MERCHANT");
        }
      }
    }
  );
}
  @override
  void dispose() {
    _deeplinkService.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final wallet =
        Provider.of<WalletProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "E-Money Wallet",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text("Saldo Wallet",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              "Rp ${wallet.balance}",
              style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const SetPinPage(),
                  ),
                );
              },
              child: const Text(
                "Buat PIN Wallet",
              ),
            ),
            const Text(
              "Payment Request",
              style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height:10),

            ElevatedButton(
              onPressed:(){
                Navigator.push(context,
                  MaterialPageRoute(
                    builder:(context)=>
                    const TransactionHistoryPage(),
                  ),
                );
              },
              child:
              const Text("History Transaksi",
                ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Padding(
                padding:const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text(
                          wallet.transaction == null
                          ? "Tidak ada transaksi"
                          : wallet.transaction!.status,
                        ),

                        const SizedBox(height:10),

                        Text(
                          wallet.transaction == null
                          ? "Amount: Rp0"
                          : "Amount: Rp ${wallet.transaction!.amount}",
                        ),

                        const SizedBox(height:10),

                        Text(
                          wallet.transaction == null
                          ? "Transaction ID: -"
                          : "Transaction ID: ${wallet.transaction!.transactionId}",
                        ),

                        const SizedBox(height:20),

                        ElevatedButton(
                          onPressed: wallet.transaction == null ? null: (){
                            showDialog(
                              context: context,
                              builder: (context){
                                final pinController = TextEditingController();
                                return AlertDialog(
                                  title: const Text(
                                    "2FA Verification",
                                  ),
                                  content: TextField(
                                    controller: pinController,
                                    keyboardType: TextInputType.number,
                                    obscureText: true,
                                    decoration:
                                      const InputDecoration(
                                        labelText: "Masukkan PIN",
                                      ),
                                  ),
                                  actions:[
                                    TextButton(
                                      onPressed: () async {
                                        final correct = await PinService().verifyPin(pinController.text,);
                                        Navigator.pop(context);
                                        if(correct){
                                          final transactionId = wallet.transaction!.transactionId;
                                          final amount = wallet.transaction!.amount;
                                          final success = await wallet.pay();
                                        if(success && wallet.jwtToken != null){
                                          final apiSuccess = await PaymentService().payment(
                                            transactionId: transactionId, amount: amount, token: wallet.jwtToken!,
                                          );
                                        if (apiSuccess) {
                                          await CallbackService().sendResult(
                                            transactionId: transactionId, amount: amount, success: true,
                                          );
                                        }
                                      }
                                    }
                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content:
                                            Text("PIN salah",
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child:
                                    const Text("Konfirmasi",
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        "Bayar",
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}