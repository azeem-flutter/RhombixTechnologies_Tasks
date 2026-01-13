import 'package:campuspulse/features/notification/model/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'authentication_repository.dart';

class NotificationRepository {
  static final instance = NotificationRepository();
  final _db = FirebaseFirestore.instance;

  String get _uid => AuthenticationRepository.instance.authUser!.uid;

  CollectionReference get _notificationRef =>
      _db.collection('Users').doc(_uid).collection('Notifications');

  Future<void> createNotification(AppNotification notification) async {
    await _notificationRef.doc(notification.id).set(notification.toJson());
  }

  Stream<List<AppNotification>> getNotifications() {
    return _notificationRef
        .orderBy('receivedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => AppNotification.fromJson(
                  doc.id,
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Future<void> markAsRead(String id) async {
    await _notificationRef.doc(id).update({'isRead': true});
  }
}
