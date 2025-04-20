import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';

class AuthUserModel {
  final String? id;
  final String email;
  final String? name;
  final String? password;
  final String? photoUrl;
  final String? role;
  final DateTime? createdAt;
  final bool? googleSignIn;

  AuthUserModel({
    this.id,
    required this.email,
    this.name,
    this.password,
    this.photoUrl,
    this.role,
    this.createdAt,
    this.googleSignIn,
  });

  // Factory to create AuthUserModel from Firestore data
  factory AuthUserModel.fromFirestore(Map<String, dynamic> data, String id) {
    return AuthUserModel(
      id: id,
      email: data['email'] as String,
      name: data['name'] as String?,
      password: data['password'] as String?,
      photoUrl: data['photoUrl'] as String?,
      role: data['role'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      googleSignIn: data['googleSignIn'] as bool?,
    );
  }

  // Convert AuthUserModel to Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
      'password': password,
      'photoUrl': photoUrl,
      'role': role,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'googleSignIn': googleSignIn,
    };
  }

  // Convert AuthUserModel to AuthUser entity
  AuthUser toEntity() {
    return AuthUser(
      id: id,
      email: email,
      name: name,
      password: password,
      photoUrl: photoUrl,
      role: role,
      createdAt: createdAt, 
      googleSignIn: googleSignIn,
    );
  }

  // Create AuthUserModel from AuthUser entity
  factory AuthUserModel.fromEntity(AuthUser user) {
    return AuthUserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      password: user.password,
      photoUrl: user.photoUrl,
      role: user.role,
      createdAt: user.createdAt,
      googleSignIn: user.googleSignIn,
    );
  }
}