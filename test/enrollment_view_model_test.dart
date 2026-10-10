import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hetman_boxing_club/features/enrollment/presentation/view_model/enrollment_view_model.dart';

void main() {
  test('rejects a short name before signup', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(enrollmentViewModelProvider.notifier).submit(
      name: 'A',
      phone: '500123456',
      email: 'anna@example.com',
      note: '',
    );

    final state = container.read(enrollmentViewModelProvider);
    expect(state.submitted, isFalse);
    expect(state.error, isNotNull);
  });

  test('accepts a complete free-training signup', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(enrollmentViewModelProvider.notifier);
    notifier.selectGroup('dzieci');
    notifier.submit(
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
  });
}
