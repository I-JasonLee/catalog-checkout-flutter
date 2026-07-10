import 'package:shared_preferences/shared_preferences.dart';


class PinService {


  Future<void> savePin(String pin) async {

    final prefs =
        await SharedPreferences.getInstance();


    await prefs.setString(
      "wallet_pin",
      pin,
    );

  }



  Future<String?> getPin() async {

    final prefs =
        await SharedPreferences.getInstance();


    return prefs.getString(
      "wallet_pin",
    );

  }



  Future<bool> verifyPin(String pin) async {


    final savedPin =
        await getPin();


    return savedPin == pin;

  }

}