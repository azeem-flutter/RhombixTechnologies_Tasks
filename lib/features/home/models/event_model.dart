import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String userId;
  final String title;
  final String date;
  final String time;
  final String location;
  final String type;
  final bool isImportant;
  final String description;
  final DateTime createdAt;
  final bool notificationSent;

  EventModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.type,
    required this.isImportant,
    required this.description,
    required this.createdAt,
    this.notificationSent = false,
  });

  // Empty constructor for fallback / factory initialization
  static EventModel empty() => EventModel(
    id: '',
    userId: '',
    title: '',
    date: '',
    time: '',
    location: '',
    type: '',
    isImportant: false,
    description: '',
    createdAt: DateTime.now(),
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'date': date,
      'time': time,
      'location': location,
      'type': type,
      'isImportant': isImportant,
      'description': description,
      'createdAt': createdAt,
      'notificationSent': notificationSent,
    };
  }

  factory EventModel.fromSnapshot(DocumentSnapshot doc) {
    if (!doc.exists) return EventModel.empty();
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return EventModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      title: data['title'] ?? '',
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      location: data['location'] ?? '',
      type: data['type'] ?? '',
      isImportant: data['isImportant'] ?? false,
      description: data['description'] ?? '',
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      notificationSent: data['notificationSent'] ?? false,
    );
  }

  DateTime get eventDateTime {
    final dateParts = date.split('/');
    final day = int.parse(dateParts[0]);
    final month = int.parse(dateParts[1]);
    final year = int.parse(dateParts[2]);
    final timeParts = time.split(' ');
    final hm = timeParts[0].split(':');
    int hour = int.parse(hm[0]);
    final min = int.parse(hm[1]);
    final ampm = timeParts[1];
    if (ampm == 'PM' && hour != 12) hour += 12;
    if (ampm == 'AM' && hour == 12) hour = 0;
    return DateTime(year, month, day, hour, min);
  }
}
