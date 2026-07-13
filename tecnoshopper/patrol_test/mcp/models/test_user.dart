class TestUser {
  final String email;
  final String password;

  const TestUser({
    required this.email,
    required this.password,
  });

  factory TestUser.fromJson(Map<String, dynamic> json) {
    return TestUser(
      email: json['email'],
      password: json['password'],
    );
  }
}