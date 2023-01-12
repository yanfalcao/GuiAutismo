import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:guiautismo/model/notice.dart';
import 'package:guiautismo/services/evaluation_service.dart';
import 'package:guiautismo/services/notice_service.dart';
import 'package:rxdart/rxdart.dart';

class EvaluationBloc implements BlocBase {
  final _parametersSubject = BehaviorSubject<List<dynamic>>();
  final _commentsSubject = BehaviorSubject<List<dynamic>>();

  Sink get inParameters => _parametersSubject.sink;
  Stream get outParameters => _parametersSubject.stream;

  Sink get inComments => _commentsSubject.sink;
  Stream get outComments => _commentsSubject.stream;

  void initParameters(String placeId) async{
    inParameters.add(
        await (EvaluationService.instance).fetchParametersScore(placeId)
    );
  }

  void initComments(String placeId) async{
    inComments.add(
        await (EvaluationService.instance).fetchComments(placeId)
    );
  }

  @override
  void dispose() {
    _parametersSubject.close();
    _commentsSubject.close();
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