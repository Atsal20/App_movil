class Usuario {
  final String id;             // ID de Firebase (document ID)
  final String username;       // Nombre de usuario único
  final String email;          // Correo electrónico
  final String? password;      // Contraseña (opcional si se registra por Google)
  final List<String> grupos;   // IDs de grupos donde participa

  Usuario({
    required this.id,
    required this.username,
    required this.email,
    this.password,
    required this.grupos,
  });

  // Método para convertir a Map (para subir a Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'grupos': grupos,
    };
  }

  // Método para crear un Usuario desde un Map (leer de Firestore)
  factory Usuario.fromMap(Map<String, dynamic> map, String id) {
    return Usuario(
      id: id,
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      grupos: List<String>.from(map['grupos'] ?? []),
    );
  }
}
