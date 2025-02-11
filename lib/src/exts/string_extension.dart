extension StringUtils on String {
  bool get isSvgImage => toLowerCase().endsWith('.svg');
}
