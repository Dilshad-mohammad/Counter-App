class User {
  final String username;
  final int count;

  User({required this.username, required this.count});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'count': count,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      count: map['count'],
    );
  }
}