class UserModel {
  final String? id;
  final String token;
  final String? name;
  // final String? email
  final String? email;
  // final String? verifyStatus;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["user"]["id"].toString(),
      token: json["token"],
      name: json["user"]["name"],
      email: json["user"]["email"],
      // verifyStatus: json["user"]["verify_status"]==null
    );
  }
  UserModel({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
    // required this.

    // required this.verifyStatus
  });
}
