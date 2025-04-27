/// Modelo que representa un gasto registrado en un grupo
class Tarea {
  final String id;
  final String nombre;
  final String descripcion;
  final DateTime fecha;
  final List<String> repartidoEntre;

  Tarea({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.fecha,
    required this.repartidoEntre,
  });

  factory Tarea.fromMap(Map<String, dynamic> data, String documentId) {
    return Tarea(
      id: documentId,
      nombre: data['nombre'] ?? '',
      descripcion: data['descripcion'] ?? '',
      fecha: (data['fecha'] as Timestamp).toDate(),
      repartidoEntre: List<String>.from(data['repartidoEntre'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'fecha': fecha,
      'repartidoEntre': repartidoEntre,
    };
  }
}
