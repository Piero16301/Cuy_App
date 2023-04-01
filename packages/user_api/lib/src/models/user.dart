import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// {@template user}
/// Modelo de datos para un usuario
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.userId,
    required this.username,
    required this.password,
    required this.name,
    required this.lastName,
    required this.email,
  });

  /// Crea una instancia de [User] a partir de un [Map]
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Crea un [Map] a partir de una instancia de [User]
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// ID del usuario
  final String userId;

  /// Nombre de usuario
  final String username;

  /// Contraseña
  final String password;

  /// Nombre
  final String name;

  /// Apellido
  final String lastName;

  /// Correo electrónico
  final String email;

  @override
  List<Object?> get props => [
        userId,
        username,
        password,
        name,
        lastName,
        email,
      ];
}
