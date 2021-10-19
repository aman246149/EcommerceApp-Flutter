import 'package:flutter/material.dart';

class ThemeSwitcherProvider with ChangeNotifier{

  bool _isDark=false;

  bool getTheme(){
    return _isDark;
  }

  void setTheme(){
      if(_isDark==true)
          _isDark=false;
      else
        _isDark=true;
      notifyListeners();
  }

}