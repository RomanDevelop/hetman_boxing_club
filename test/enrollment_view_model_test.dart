import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hetman_boxing_club/app/di/providers.dart';
import 'package:hetman_boxing_club/core/services/external_links.dart';
import 'package:hetman_boxing_club/features/enrollment/presentation/view_model/enrollment_view_model.dart';

class _MemoryLinks implements ExternalLinks {
  Uri? last;

  @override
  Future<bool> open(Uri uri) async {
    last = uri;
    return true;
  }
}

void main() {
  test('rejects a short name before signup', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(enrollmentViewModelProvider.notifier).submit(
      name: 'A',
      phone: '500123456',
      email: 'anna@example.com',
      note: '',
    );

    final state = container.read(enrollmentViewModelProvider);
    expect(state.submitted, isFalse);
    expect(state.error, isNotNull);
  });

  test('accepts a complete free-training signup', () async {
    final links = _MemoryLinks();
    final container = ProviderContainer(
      overrides: [externalLinksProvider.overrideWithValue(links)],
    );
    addTearDown(container.dispose);

    final notifier = container.read(enrollmentViewModelProvider.notifier);
    notifier.selectGroup('dzieci');
    await notifier.submit(
      name: 'Anna Kowalska',
      phone: '500 123 456',
      email: 'anna@example.com',
      note: 'Chcę przyjść z synem.',
    );

    final state = container.read(enrollmentViewModelProvider);
    expect(state.submitted, isTrue);
    expect(state.error, isNull);
    expect(state.groupId, 'dzieci');
    expect(state.name, 'Anna Kowalska');
    expect(links.last?.host, 'wa.me');
    expect(links.last?.path, '/48500557114');
    expect(links.last?.queryParameters['text'], contains('Anna Kowalska'));
    expect(links.last?.queryParameters['text'], contains('BOXING KIDS'));
  });
}
