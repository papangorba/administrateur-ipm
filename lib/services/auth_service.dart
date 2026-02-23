import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> register(
      String email,
      String password,
      String prenom,
      String nom,
      ) async {
    try {
      UserCredential credential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        uid: credential.user!.uid,
        email: email,
        prenom: prenom,
        nom: nom,
      );

      await _firestore.collection("users").doc(user.uid).set(user.toMap());

      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }


  Future<User?> login(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
