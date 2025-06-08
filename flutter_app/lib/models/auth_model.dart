class AuthModel {
  final int id;
  final String email;

  AuthModel({ required this.id, required this.email});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'],
      email: json['email'],
    );
  }
}