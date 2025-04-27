enum Role { user, admin }

class User {
  final String id;
  final String userName;
  final String password;
  final String email;
  final Role role;
  final String profileImage;

  User({
    required this.id,
    required this.userName,
    required this.password,
    required this.email,
    required this.role,
    required this.profileImage,
  });
}