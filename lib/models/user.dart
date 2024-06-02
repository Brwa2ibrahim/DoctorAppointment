class UserModel {
  String uid;
  String email;
  String displayName;
  String location;
  String createdAt;
  String profilePic;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.location,
    required this.createdAt,
    required this.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"] ?? "",
      email: json["email"],
      displayName: json["displayName"],
      location: json["location"],
      createdAt: json["created_at"],
      profilePic: json["profilePic"],
    );
  }
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "displayName": displayName,
        "location": location,
        "created_at": createdAt,
        "profilePic": profilePic,
      };
}
