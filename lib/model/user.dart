class UserModel {
  final int id;
  final String name;
  final String phoneNumber;
  final String email;
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
        role: json['role'],
      );
}
