/// Modelo que representa a un usuario de la app
class Usuario {
  final String id;
  final String nombre;
  final String email;
  final List<String> grupos;

  Usuario({
    required this.id,
    required this.nombre,
    required this.email,
    required this.grupos,
  });

  /// Crea un Usuario desde un mapa de Firestore
  factory Usuario.fromMap(Map<String, dynamic> data, String documentId) {
    return Usuario(
      id: documentId,
      nombre: data['nombre'] ?? '',
      email: data['email'] ?? '',
      grupos: List<String>.from(data['grupos'] ?? []),
    );
  }

  /// Convierte un Usuario en un mapa para Firestore
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'email': email,
      'grupos': grupos,
    };
  }
}
