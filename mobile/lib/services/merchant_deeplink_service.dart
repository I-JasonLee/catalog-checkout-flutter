import 'dart:async';
import 'package:app_links/app_links.dart';

class MerchantDeeplinkService {

  final AppLinks _appLinks = AppLinks();

  StreamSubscription<Uri>? _subscription;

  Uri? lastUri;


  Future<void> init(
      Function(Uri uri) onReceive
  ) async {


    // =====================
    // COLD START
    // =====================

    final initialUri =
        await _appLinks.getInitialLink();


    if(initialUri != null){

      lastUri = initialUri;

      onReceive(initialUri);

    }



    // =====================
    // APP SUDAH HIDUP
    // =====================

    _subscription =
        _appLinks.uriLinkStream.listen(
      (uri){


        // cegah double callback

        if(uri.toString() ==
            lastUri?.toString()){

          return;

        }


        lastUri = uri;

        onReceive(uri);


      },
      onError:(error){

        print(
          "Merchant Deeplink Error: $error"
        );

      },
    );


  }



  void dispose(){

    _subscription?.cancel();

  }

}