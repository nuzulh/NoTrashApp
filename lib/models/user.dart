class UserModel {
  final String id;
  final String role;
  final String name;
  final String email;
  final String phoneNumber;

  UserModel({
    required this.id,
    required this.role,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? '',
        role: json['role'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        phoneNumber: json['phone_number'] ?? '',
      );

  Map<String, String> toJson() => {
        'id': id,
        'role': role,
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
      };
}
