class TwoFAService {


  Future<bool> verify({

    required String method,
    required String value,

  }) async {


    switch(method){


      case "pin":

        return value == "123456";


      case "otp":

        return value == "999999";


      case "totp":

        return value == "111111";


      default:

        return false;

    }

  }


}