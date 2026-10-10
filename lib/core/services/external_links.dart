import 'package:url_launcher/url_launcher.dart';

abstract interface class ExternalLinks {
  Future<bool> open(Uri uri);
}

final class UrlLauncherLinks implements ExternalLinks {
  const UrlLauncherLinks();

  @override
  Future<bool> open(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.platformDefault);
    } on Object {
      return false;
    }
  }
}
