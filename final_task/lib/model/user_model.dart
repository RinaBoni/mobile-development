class UserModel {
  late String login;
  late String name;
  late String email;
  late String password;

  UserModel(this.login, this.name, this.email, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'login': login,
      'name': name,
      'email': email,
      'password': password
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    login = map['login'];
    name = map['name'];
    email = map['email'];
    password = map['password'];
  }
}
