import 'package:cloud_firestore/cloud_firestore.dart';

/// Modelo que representa un grupo de gastos compartidos
class Grupo {
  final String id;
  final String nombreGrupo;
  final String codigoAcceso;
  final DateTime fechaCreacion;
  final List<String> miembros;

  Grupo({
    required this.id,
    required this.nombreGrupo,
    required this.codigoAcceso,
    required this.fechaCreacion,
    required this.miembros,
  });

  factory Grupo.fromMap(Map<String, dynamic> data, String documentId) {
    return Grupo(
      id: documentId,
      nombreGrupo: data['nombreGrupo'] ?? '',
      codigoAcceso: data['codigoAcceso'] ?? '',
      fechaCreacion: (data['fechaCreacion'] as Timestamp).toDate(),
      miembros: List<String>.from(data['miembros'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombreGrupo': nombreGrupo,
      'codigoAcceso': codigoAcceso,
      'fechaCreacion': fechaCreacion,
      'miembros': miembros,
    };
  }
}
