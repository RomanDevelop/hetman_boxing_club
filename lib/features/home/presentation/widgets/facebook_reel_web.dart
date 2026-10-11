import 'dart:async';
import 'dart:js_interop';

import 'package:hetman_boxing_club/features/home/presentation/widgets/facebook_reel_url.dart';
import 'package:web/web.dart' as web;

const facebookReelEmbedsInline = true;

Future<void> showFacebookReelOverlay() {
  final done = Completer<void>();
  final overlay = web.HTMLDivElement();
  overlay.style
    ..position = 'fixed'
    ..left = '0'
    ..top = '0'
    ..width = '100%'
    ..height = '100%'
    ..zIndex = '2147483646'
    ..backgroundColor = 'rgba(0,0,0,0.88)'
    ..display = 'flex'
    ..alignItems = 'center'
    ..justifyContent = 'center';

  final viewportWidth = web.window.innerWidth;
  final viewportHeight = web.window.innerHeight;
  var scale = (viewportWidth * 0.9) / facebookReelWidth;
  if (facebookReelHeight * scale > viewportHeight * 0.86) {
    scale = (viewportHeight * 0.86) / facebookReelHeight;
  }
  final width = (facebookReelWidth * scale).round();
  final height = (facebookReelHeight * scale).round();

  final frame = web.HTMLIFrameElement();
  frame.src = facebookReelEmbed;
  frame.width = '$width';
  frame.height = '$height';
  frame.style.border = 'none';
  frame.style.width = '${width}px';
  frame.style.height = '${height}px';
  frame.allow = 'autoplay; clipboard-write; encrypted-media; picture-in-picture; web-share';
  frame.allowFullscreen = true;
  frame.setAttribute('scrolling', 'no');

  final close = web.HTMLButtonElement();
  close.type = 'button';
  close.textContent = '×';
  close.setAttribute('aria-label', 'Zamknij');
  close.style
    ..position = 'absolute'
    ..top = '12px'
    ..right = '16px'
    ..width = '44px'
    ..height = '44px'
    ..border = 'none'
    ..borderRadius = '999px'
    ..backgroundColor = 'rgba(0,0,0,0.55)'
    ..color = '#ffffff'
    ..fontSize = '28px'
    ..cursor = 'pointer'
    ..lineHeight = '1';

  void dismiss() {
    overlay.remove();
    if (!done.isCompleted) done.complete();
  }

  close.addEventListener('click', ((web.Event event) {
    event.stopPropagation();
    dismiss();
  }).toJS);
  overlay.addEventListener('click', ((web.Event event) {
    if (event.target == overlay) dismiss();
  }).toJS);

  overlay.append(close);
  overlay.append(frame);
  web.document.body?.append(overlay);
  return done.future;
}
