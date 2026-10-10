import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/app/di/providers.dart';

Future<void> openClubLink(WidgetRef ref, BuildContext context, Uri uri) async {
  final opened = await ref.read(externalLinksProvider).open(uri);
  if (!opened && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nie udało się otworzyć linku na tym urządzeniu.')),
    );
  }
}
