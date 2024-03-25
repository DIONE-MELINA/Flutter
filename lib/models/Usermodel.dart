class UserModel {
  final String name;
  final String email;
  final String photoUrl;
  UserModel({
    required this.name,
    required this.email,
    required this.photoUrl,
  });
  Map<String, dynamic> toMap() {
    return {"name": name, "email": email,"photoUrl":photoUrl};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(name: map["name"] ?? "", email: map["email"] ?? "",photoUrl:map["photoUrl"]?? "");
  }
  UserModel copyWith({
    String? name,
    String? email,
    String?photoUrl,
  }) {
    return UserModel(name: name ?? this.name, email: email ?? this.email, photoUrl: photoUrl?? this.photoUrl);
  }
}
