import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guiautismo/model/notice.dart';

class NoticeService {
  static Future<List<Notice>> fetchNotices() async {
    List<Notice> notices = [];
    FirebaseFirestore storage = FirebaseFirestore.instance;

    QuerySnapshot<Map<String, dynamic>> snapshotCollection =
        await storage.collection('noticias').get();

    notices = snapshotCollection.docs
        .map<Notice>((e) => Notice.fromJson(e.data()))
        .toList();

    return notices;
  }
}
