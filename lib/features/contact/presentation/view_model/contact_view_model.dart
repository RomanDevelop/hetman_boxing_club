import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hetman_boxing_club/app/di/providers.dart';
import 'package:hetman_boxing_club/features/club/domain/club_domain.dart';

class ContactViewModel extends Notifier<ContactDetails> {
  @override
  ContactDetails build() => ref.watch(contactRepositoryProvider).getContact();
}

final contactViewModelProvider = NotifierProvider<ContactViewModel, ContactDetails>(
  ContactViewModel.new,
);
