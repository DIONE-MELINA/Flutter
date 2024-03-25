import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Userclass {
  final String name;
  final String email;
  final String photoUrl;
  Userclass({
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory Userclass.fromMap(Map<String, dynamic> map) {
    return Userclass(
      name: map['name'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Userclass.fromJson(String source) => Userclass.fromMap(json.decode(source) as Map<String, dynamic>);

  Userclass copyWith({
    String? name,
    String? email,
    String? photoUrl,
  }) {
    return Userclass(
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
