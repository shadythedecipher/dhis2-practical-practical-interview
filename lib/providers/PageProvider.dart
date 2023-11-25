import 'package:flutter/cupertino.dart';

class PageProvider extends ChangeNotifier{

  bool _containerState =false;

  bool get containerState => _containerState;

  void setContainer(bool val) {
    _containerState = val;
    notifyListeners();
  }

}