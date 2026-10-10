import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hetman_boxing_club/app/hetman_app.dart';

void main() {
  usePathUrlStrategy();
  runApp(const ProviderScope(child: HetmanApp()));
}
