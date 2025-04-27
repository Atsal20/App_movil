/// Modelo que representa un gasto registrado en un grupo
class Gasto {
  final String id;
  final String descripcion;
  final double monto;
  final DateTime fecha;
  final String pagadoPor;
  final List<String> repartidoEntre;

  Gasto({
    required this.id,
    required this.descripcion,
    required this.monto,
    required this.fecha,
    required this.pagadoPor,
    required this.repartidoEntre,
  });

  factory Gasto.fromMap(Map<String, dynamic> data, String documentId) {
    return Gasto(
      id: documentId,
      descripcion: data['descripcion'] ?? '',
      monto: (data['monto'] as num).toDouble(),
      fecha: (data['fecha'] as Timestamp).toDate(),
      pagadoPor: data['pagadoPor'] ?? '',
      repartidoEntre: List<String>.from(data['repartidoEntre'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'descripcion': descripcion,
      'monto': monto,
      'fecha': fecha,
      'pagadoPor': pagadoPor,
      'repartidoEntre': repartidoEntre,
    };
  }
}
