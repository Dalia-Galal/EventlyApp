import 'package:firebase_auth/firebase_auth.dart';

class UserDataModel {
  static String collectionName = 'Users';
  String? userId;
  String userName;
  String userEmail;


  UserDataModel({
    this.userId,
    required this.userName,
    required this.userEmail,

  });

  factory UserDataModel.fromFireStore(Map<String, dynamic> json) {
    return UserDataModel(
      userId: json['userId'],
      userName: json['userName'],
      userEmail: json['userEmail'],

    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
    };
  }
}
