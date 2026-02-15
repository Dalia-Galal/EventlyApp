import 'package:evently/models/user_data_model.dart';
import 'package:evently/services/snack_bar_services.dart';
import 'package:evently/utils/firestore_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationUtils {
  static Future<UserDataModel?> createUserWithEmailAndPassword(
    String name,
    String emailAddress,
    String password,
  ) async {
    try {
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

      return Future.value(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarServices.showSuccessMessage(
          'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        SnackBarServices.showErrorMessage('email-already-in-use');
      }
      return Future.value(null);
    }
  }

  static Future<UserDataModel?> signInWithEmailAndPassword(
    String emailAddress,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      UserDataModel? user = await FirestoreUtils.getUserFromFirestore(
        credential.user!.uid,
      );
      print('User Name${user?.userName}');
      return Future.value(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        SnackBarServices.showErrorMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        SnackBarServices.showErrorMessage(
          'Wrong password provided for that user.',
        );
      }
      return Future.value(null);
    }
  }
}
