class User {
  int? id;
  String? name;
  String? username;
  String? email;
  String? password;

  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.password,
  });

  // ignore: non_constant_identifier_names
  UserMap() {
    var mapping = <String, dynamic>{};
    // ignore: unnecessary_null_in_if_null_operators
    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['username'] = username!;
    mapping['email'] = email!;
    return mapping;
  }
}
