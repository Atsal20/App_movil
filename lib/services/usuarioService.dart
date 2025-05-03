// importaciones necesarias
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/Usuario.dart';

class UsuarioService {
  // Instancias de FirebaseAuth y Firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para registrar usuario con email y password
  Future<String?> registerUser(String username, String email, String password) async {
    try {
      // Crear usuario en Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid; // ID único del usuario creado

      // Crear usuario en Firestore
      Usuario usuario = Usuario(
        id: uid,
        username: username,
        email: email,
        password: password, // Opcional si deseas guardar la contraseña (normalmente no se guarda)
        grupos: [],
      );

      await _firestore.collection('usuarios').doc(uid).set(usuario.toMap());

      return null; // Registro exitoso
    } on FirebaseAuthException catch (e) {
      return e.message; // Retorna el error que haya ocurrido
    }
  }

  // Método para iniciar sesión con email y password
  Future<String?> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Login exitoso
    } on FirebaseAuthException catch (e) {
      return e.message; // Error de autenticación
    }
  }

  // Método para registrar o iniciar sesión con cuenta de Google
  Future<String?> registerWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return "Cancelado por el usuario"; // Si el usuario cancela el inicio de sesión
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      String uid = userCredential.user!.uid;

      // Verificar si el usuario ya existe en Firestore
      DocumentSnapshot userDoc = await _firestore.collection('usuarios').doc(uid).get();

      if (!userDoc.exists) {
        // Si no existe, crearlo
        Usuario usuario = Usuario(
          id: uid,
          username: googleUser.displayName ?? 'SinNombre',
          email: googleUser.email,
          password: null, // No hay password en login con Google
          grupos: [],
        );
        await _firestore.collection('usuarios').doc(uid).set(usuario.toMap());
      }

      return null; // Login/Registro con Google exitoso
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Método para obtener los datos del usuario logueado
  Future<Usuario?> getUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) return null;

      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection('usuarios').doc(currentUser.uid).get();

      if (snapshot.exists) {
        return Usuario.fromMap(snapshot.data()!, snapshot.id);
      } else {
        return null;
      }
    } catch (e) {
      print('Error al obtener usuario: $e');
      return null;
    }
  }
}
