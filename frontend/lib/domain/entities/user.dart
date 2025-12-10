class User {
  final String id;
  final String email;
  final String fullName;
  final bool isActive;
  final bool isSuperuser;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.isActive,
    required this.isSuperuser,
  });
}
