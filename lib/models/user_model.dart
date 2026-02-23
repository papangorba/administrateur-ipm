class UserModel {
  final String uid;
  final String email;
  final String prenom;
  final String nom;

  UserModel({
    required this.uid,
    required this.email,
    required this.prenom,
    required this.nom,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'prenom': prenom,
      'nom': nom,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      prenom: map['prenom'],
      nom: map['nom'],
    );
  }
}
