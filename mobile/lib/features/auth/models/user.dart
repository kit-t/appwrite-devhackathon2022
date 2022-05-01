class UserFields {
  static const String id = "\$id";
  static const String name = "name";
  static const String email = "email";
}

class User {
  String? id;
  String? name;
  String? email;

  User({
    this.id,
    this.name,
    this.email,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json[UserFields.id];
    name = json[UserFields.name];
    email = json[UserFields.name];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[UserFields.id] = id;
    data[UserFields.name] = name;
    data[UserFields.email] = email;
    return data;
  }
}
