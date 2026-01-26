class UserModel {
  String id;
  String email;
  String name;

  UserModel({required this.id, required this.email, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> map, String id) {
    return UserModel(id: id, email: map['email'], name: map['name'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {"email": email, "name": name};
  }
}
