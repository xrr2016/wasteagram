import '../exports.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String displayName;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final bool emailVerified;
  @HiveField(3)
  final bool isAnonymous;
  @HiveField(4)
  final UserMetadata metadata;
  @HiveField(5)
  final String phoneNumber;
  @HiveField(6)
  final String photoURL;
  @HiveField(7)
  final List<UserInfo> providerData;
  @HiveField(8)
  final String refreshToken;
  @HiveField(9)
  final String tenantId;
  @HiveField(10)
  final String uid;

  UserModel({
    required this.displayName,
    required this.email,
    required this.emailVerified,
    required this.isAnonymous,
    required this.metadata,
    required this.phoneNumber,
    required this.photoURL,
    required this.providerData,
    required this.refreshToken,
    required this.tenantId,
    required this.uid,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        displayName: json['displayName'],
        email: json['email'],
        emailVerified: json['emailVerified'],
        isAnonymous: json['isAnonymous'],
        metadata: json['metadata'],
        phoneNumber: json['phoneNumber'],
        photoURL: json['photoURL'],
        providerData: json['providerData'],
        refreshToken: json['refreshToken'],
        tenantId: json['tenantId'],
        uid: json['uid'],
      );
}
