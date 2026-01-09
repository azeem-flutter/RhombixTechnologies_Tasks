import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // keep those values final which you do not want to update
  final String id;
  String username;
  final String email;
  // Constructor for userModel
  UserModel({required this.id, required this.username, required this.email});

  // Static Function to create an empty user model
  static UserModel empty() => UserModel(id: '', username: '', email: '');

  // Convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {'Username': username, 'Email': email};
  }

  //Factory Method to create a UserModel from a firebase document snapshot
  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
