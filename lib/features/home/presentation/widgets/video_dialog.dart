import 'package:flutter/widgets.dart';
import 'package:hetman_boxing_club/features/home/presentation/widgets/facebook_reel.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> showVideoDialog(BuildContext context) {
  if (!context.mounted) return Future.value();
  if (facebookReelEmbedsInline) return showFacebookReelOverlay();
  return launchUrl(Uri.parse(facebookReelPage), mode: LaunchMode.externalApplication);
}
