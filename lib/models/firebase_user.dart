class AuthUser {
  const AuthUser({
    required this.uid,
    this.name,
    this.email,
    this.isAnonymous = false,
    this.avatarUrl,
  });

  final String uid;
  final String? name;
  final String? email;
  final bool isAnonymous;
  final String? avatarUrl;
}
