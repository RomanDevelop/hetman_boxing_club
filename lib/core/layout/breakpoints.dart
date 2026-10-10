abstract final class Breakpoints {
  static const desktop = 1080.0;

  static bool isDesktop(double width) => width >= desktop;
}
