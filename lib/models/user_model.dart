class UserModel {
  final String name;
  final String email;
  final String password;
  String? role;
  String? phone;
  String? avatar;
  UserModel({
    required this.name,
    required this.email,
    required this.password,
    this.role,
    this.phone,
    this.avatar,
  });
}
