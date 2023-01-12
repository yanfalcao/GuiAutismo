import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc implements BlocBase {
  final _userSubject = BehaviorSubject<User>();

  BehaviorSubject get userSubject => _userSubject;
  Sink get inUser => _userSubject.sink;
  Stream get outUser => _userSubject.stream;

  @override
  void dispose() {
    _userSubject.close();
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