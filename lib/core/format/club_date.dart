abstract final class ClubDate {
  static const _months = [
    'sty',
    'lut',
    'mar',
    'kwi',
    'maj',
    'cze',
    'lip',
    'sie',
    'wrz',
    'paź',
    'lis',
    'gru',
  ];

  static String short(DateTime date) => '${date.day} ${_months[date.month - 1]} ${date.year}';
}
