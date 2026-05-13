import 'package:equatable/equatable.dart';

/// User entity for authentication
class UserEntity extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
  final String token;

  const UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.token,
  });
  
  @override
  List<Object?> get props => [id, email, firstName, lastName, avatar, token];
}
