import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:guiautismo/model/notice.dart';
import 'package:guiautismo/services/notice_service.dart';
import 'package:rxdart/rxdart.dart';

class NoticeBloc implements BlocBase {
  List<Notice> places = [];
  final _noticeSubject = BehaviorSubject<List<Notice>>();

  Sink get inNotices => _noticeSubject.sink;
  Stream get outNotices => _noticeSubject.stream;

  void initNotices() async{
    inNotices.add(
      await NoticeService.fetchNotices()
    );
  }

  @override
  void dispose() {
    _noticeSubject.close();
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