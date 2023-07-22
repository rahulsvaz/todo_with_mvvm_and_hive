import 'package:flutter/foundation.dart';

class ThemeModel with ChangeNotifier {
  bool _ifDark = false;

  get ifDark => _ifDark;

  darkThemeToggle() {
    _ifDark = !_ifDark;

    notifyListeners();
  }
}
