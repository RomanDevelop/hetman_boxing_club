import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hetman_boxing_club/app/hetman_app.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('home hero shows the club headline', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: HetmanApp()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('CHARAKTER'), findsOneWidget);
    expect(find.text('WIĘCEJ NIŻ SPORT'), findsOneWidget);
  });
}
