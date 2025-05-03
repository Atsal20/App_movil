import 'package:cloud_firestore/cloud_firestore.dart';

class Tarea {
  final String id;                 // ID único de la tarea
  final String nombre;             // Nombre de la tarea
  final String descripcion;        // Descripción de la tarea
  final DateTime fecha;             // Fecha límite de la tarea
  final List<String> repartidoEntre; // Lista de IDs de usuarios asignados

  Tarea({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.fecha,
    required this.repartidoEntre,
  });

  // Método para convertir a Map (para subir a Firestore)
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'fecha': fecha,
      'repartidoEntre': repartidoEntre,
    };
  }

  // Método para crear una Tarea desde un Map (leer de Firestore)
  factory Tarea.fromMap(Map<String, dynamic> map, String id) {
    return Tarea(
      id: id,
      nombre: map['nombre'] ?? '',
      descripcion: map['descripcion'] ?? '',
      fecha: (map['fecha'] as Timestamp).toDate(),
      repartidoEntre: List<String>.from(map['repartidoEntre'] ?? []),
    );
  }
}
