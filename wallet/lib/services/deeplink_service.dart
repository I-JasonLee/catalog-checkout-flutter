import 'package:app_links/app_links.dart';
import 'dart:async';

class DeeplinkService {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription? _sub;

  void init(void Function(Uri uri) onLink) {
    _sub = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        onLink(uri);
      }
    });
  }

  void dispose() {
    _sub?.cancel();
  }
}