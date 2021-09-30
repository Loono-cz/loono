class AuthUser {
  const AuthUser({
    required this.uid,
    this.name,
    this.isAnonymous = false,
    this.avatarUrl,
  });

  final String uid;
  final String? name;
  final bool isAnonymous;
  final String? avatarUrl;
}
