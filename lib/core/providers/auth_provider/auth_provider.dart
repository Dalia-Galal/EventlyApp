import 'package:evently/models/user_data_model.dart';
import 'package:evently/utils/firebase_authentication_utils.dart';
import 'package:evently/utils/firestore_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationProvider extends ChangeNotifier {
  UserDataModel? _user;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isInitialized = false;
  bool _googleSignInInitialized = false;

  UserDataModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _user != null;
  bool get isInitialized => _isInitialized;

  AuthenticationProvider() {
    _init();
  }

  Future<void> _init() async {
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) async {
      debugPrint('=== authStateChanges fired ===');
      debugPrint('=== firebaseUser: $firebaseUser ===');
      if (firebaseUser == null) {
        _user = null;
        _isInitialized = true;
        notifyListeners();
      } else {
        if (_user == null) {
          debugPrint(
            '=== fetching user from Firestore: ${firebaseUser.uid} ===',
          );
          _user = await FirestoreUtils.getUserFromFirestore(firebaseUser.uid);
        }
      }
      _isInitialized = true;
      notifyListeners();
    });
  }

  Future<void> _initializeGoogleSignIn() async {
    if (!_googleSignInInitialized) {
      await GoogleSignIn.instance.initialize(
        serverClientId: dotenv.env['ServerClientId'],
      );
      _googleSignInInitialized = true;
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _user = await FirebaseAuthenticationUtils.createUserWithEmailAndPassword(
        name,
        email,
        password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          _errorMessage = 'Password must be at least 6 characters.';
        case 'email-already-in-use':
          _errorMessage = 'An account already exists with this email.';
        case 'invalid-email':
          _errorMessage = 'Please enter a valid email address.';
        case 'network-request-failed':
          _errorMessage = 'No internet connection.';
        default:
          _errorMessage = 'Something went wrong, please try again.';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _user = await FirebaseAuthenticationUtils.signInWithEmailAndPassword(
        email,
        password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          _errorMessage = 'Wrong email or password.';
        case 'user-not-found':
          _errorMessage = 'No account found with this email.';
        case 'wrong-password':
          _errorMessage = 'Incorrect password, please try again.';
        case 'user-disabled':
          _errorMessage = 'This account has been disabled.';
        case 'too-many-requests':
          _errorMessage = 'Too many attempts, please try again later.';
        case 'network-request-failed':
          _errorMessage = 'No internet connection.';
        default:
          _errorMessage = 'Something went wrong, please try again.';
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _initializeGoogleSignIn();

      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        final newUser = UserDataModel(
          userId: userCredential.user!.uid,
          userName: userCredential.user!.displayName ?? '',
          userEmail: userCredential.user!.email ?? '',
        );
        debugPrint("Firebase user: ${userCredential.user}");
        await FirestoreUtils.addUser(newUser);
        _user = newUser;
      } else {
        _user = await FirestoreUtils.getUserFromFirestore(
          userCredential.user!.uid,
        );
      }
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        debugPrint('Google sign-in cancelled by user');
      } else {
        _errorMessage = 'Google sign-in failed: ${e.toString()}';
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword(String userEmail) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: userEmail);
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    if (_googleSignInInitialized) {
      await GoogleSignIn.instance.signOut();
    }
    _user = null;
    notifyListeners();
  }
}
