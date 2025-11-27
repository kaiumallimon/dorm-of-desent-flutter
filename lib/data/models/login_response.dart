import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable{
  final bool success;
  final String accessToken;
  final String refreshToken;
  final DateTime expiresIn;
  final UserData userData;

  const LoginResponse({
    required this.success,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.userData,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      expiresIn: DateTime.parse(json['expiresIn']),
      userData: UserData.fromJson(json['userData']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn.toIso8601String(),
      'userData': userData.toJson(),
    };
  }

  @override
  List<Object?> get props => [success, accessToken, refreshToken, expiresIn, userData];
}

class UserData extends Equatable {
  final String id;
  final String email;
  final String name;
  final String role;

  const UserData({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
    };
  }

  @override
  List<Object?> get props => [id, email, name, role];
} 

