
import 'dart:convert';

List<User> allUsersFromJson(String str) {
  final jsonData = json.decode(str);
  return  List<User>.from(jsonData.map((x) => User.fromJson(x)));
}

class User {
  final int id;
  final String username;
  final String email;
  final UserCompany company;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] as int,
        username: json['username'] as String,
        email: json['email'] as String,
        company: UserCompany.fromJson(json['company'])
    );
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email, company: $company}';
  }
}

class UserCompany {
  final String name;
  final String catchPhrase;
  final String bs;

  UserCompany({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory UserCompany.fromJson(Map<String, dynamic> json) {
    return UserCompany(
        name: json['name'] as String,
        catchPhrase: json['catchPhrase'] as String,
        bs: json['bs'] as String);
  }

  @override
  String toString() {
    return 'UserCompany{name: $name, catchPhrase: $catchPhrase, bs: $bs}';
  }
}
