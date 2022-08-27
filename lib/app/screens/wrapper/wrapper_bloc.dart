import 'dart:async';

class WrapperBloc {
  WrapperBloc._();

  static final ins = WrapperBloc._();

  //============================================
  final StreamController<int> _currentPageController =
      StreamController<int>.broadcast();

  Stream<int> get currentPageStream => _currentPageController.stream;

  //==============================================

  changeCurrentPage(int i) {
    _currentPageController.sink.add(i);
  }

  void dispose() {
    _currentPageController.close();
  }
}
