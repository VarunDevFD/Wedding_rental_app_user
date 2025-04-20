class AuthUser {
  final String? id;
  final String? name;
  final String email;
  final String? password;
  final String? photoUrl;
  final String? role;
  final DateTime? createdAt;
  final bool? googleSignIn;

  AuthUser({
    this.id,
    required this.email,
    this.name,
    this.password,
    this.photoUrl,
    this.role,
    this.createdAt,
    this.googleSignIn,
  });

  fold(Never Function(dynamic error) param0, Future<Null> Function(dynamic authUser) param1) {}
}
