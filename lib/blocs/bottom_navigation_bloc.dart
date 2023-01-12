import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class BottomNavigationBloc implements BlocBase {
  final _currentIndex = BehaviorSubject<int>();

  Sink get inCurrentIndex => _currentIndex.sink;
  Stream get outCurrentIndex => _currentIndex.stream;

  @override
  void dispose() {
    _currentIndex.close();
  }

  @override
  void addListener(listener) {}

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}
}