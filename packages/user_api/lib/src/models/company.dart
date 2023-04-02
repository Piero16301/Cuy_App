import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_api/src/models/models.dart';

part 'company.g.dart';

/// {@template company}
/// Modelo de datos para una compañía
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class Company extends Equatable {
  /// {@macro company}
  const Company({
    required this.id,
    required this.ruc,
    required this.businessName,
    required this.role,
  });

  /// Crea una instancia de [Company] a partir de un [Map]
  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  /// Crea un [Map] a partir de una instancia de [Company]
  Map<String, dynamic> toJson() => _$CompanyToJson(this);

  /// ID
  final int id;

  /// RUC
  final String ruc;

  /// Nombre corporativo
  final String businessName;

  /// Rol
  final Role role;

  @override
  List<Object?> get props => [
        id,
        ruc,
        businessName,
        role,
      ];
}
