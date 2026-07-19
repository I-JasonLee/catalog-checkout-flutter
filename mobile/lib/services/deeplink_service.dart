import 'dart:async';
import 'package:app_links/app_links.dart';

class DeeplinkService {

  final AppLinks _appLinks = AppLinks();

  StreamSubscription? _sub;

  void init(
      Function(Uri uri) onLink,
      ){

    _sub =
        _appLinks.uriLinkStream.listen(

              (uri){

            if(uri != null){

              onLink(uri);

            }

          },

    );

  }

  void dispose(){

    _sub?.cancel();

  }

}