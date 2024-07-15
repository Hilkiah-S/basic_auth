// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String fullname;
  String Email;
  String Password;
  User({
    required this.fullname,
    required this.Email,
    required this.Password,
  });

  User copyWith({
    String? fullname,
    String? Email,
    String? Password,
  }) {
    return User(
      fullname: fullname ?? this.fullname,
      Email: Email ?? this.Email,
      Password: Password ?? this.Password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullname': fullname,
      'Email': Email,
      'Password': Password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fullname: map['fullname'] as String,
      Email: map['Email'] as String,
      Password: map['Password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'User(fullname: $fullname, Email: $Email, Password: $Password)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.fullname == fullname &&
        other.Email == Email &&
        other.Password == Password;
  }

  @override
  int get hashCode => fullname.hashCode ^ Email.hashCode ^ Password.hashCode;
}
