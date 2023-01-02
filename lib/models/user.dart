class UserModel {
  UserModel(
      {required this.uid, required this.emailVerified, required this.email});

  final String uid;
  final bool emailVerified;
  final String? email;
}
