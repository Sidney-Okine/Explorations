import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String displayName;
  final String email;
  final String? photoURL;
  final bool isEmailVerified;
  final bool isAnonymous;
  final String? phoneNumber;
  final String? refreshToken;
  final String? tenantId;
  final int? token;
  final String? username;
  final String? accessToken;
  final String? providerId;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    this.photoURL,
    required this.isEmailVerified,
    required this.isAnonymous,
    this.phoneNumber,
    this.refreshToken,
    this.tenantId,
    this.token,
    this.username,
    this.accessToken,
    this.providerId,
  });

  factory UserModel.fromUserCredential(UserCredential userCredential) {
    return UserModel(
      uid: userCredential.user!.uid,
      displayName: userCredential.user!.displayName!,
      email: userCredential.user!.email!,
      photoURL: userCredential.user!.photoURL,
      isEmailVerified: userCredential.user!.emailVerified,
      isAnonymous: userCredential.user!.isAnonymous,
      phoneNumber: userCredential.user!.phoneNumber,
      refreshToken: userCredential.user!.refreshToken,
      tenantId: userCredential.user!.tenantId,
      token: userCredential.credential!.token,
      username: userCredential.additionalUserInfo?.profile!['login'],
      accessToken: userCredential.credential!.accessToken,
      providerId: userCredential.credential!.providerId,

    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      photoURL: json['photoURL'],
      isEmailVerified: json['isEmailVerified'],
      isAnonymous: json['isAnonymous'],
      phoneNumber: json['phoneNumber'],
      refreshToken: json['refreshToken'],
      tenantId: json['tenantId'],
      token: json['token'],
      username: json['username'],
      accessToken: json['accessToken'],
      providerId: json['providerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
      'isEmailVerified': isEmailVerified,
      'isAnonymous': isAnonymous,
      'phoneNumber': phoneNumber,
      'refreshToken': refreshToken,
      'tenantId': tenantId,
      'token': token,
      'username': username,
      'accessToken': accessToken,
      'providerId': providerId,
    };
  }
}
