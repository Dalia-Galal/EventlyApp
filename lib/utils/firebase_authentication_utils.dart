import 'package:evently/models/user_data_model.dart';
import 'package:evently/utils/firestore_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationUtils {
  static Future<UserDataModel?> createUserWithEmailAndPassword(
    String name,
    String emailAddress,
    String password,
  ) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
    UserDataModel user = UserDataModel(
      userId: credential.user!.uid,
      userName: name,
      userEmail: emailAddress,
    );

    await FirestoreUtils.addUser(user);
    return user;
  }

  static Future<UserDataModel?> signInWithEmailAndPassword(
    String emailAddress,
    String password,
  ) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    UserDataModel? user = await FirestoreUtils.getUserFromFirestore(
      credential.user!.uid,
    );
    return user;
  }
}
