import 'package:autoagent/app/modules/user/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  final auth = fb.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  late final Future<void> _init = googleSignIn.initialize(
    serverClientId:
        '1067878525854-cuk12s1bcru9sh8uir6t5c36ifkgu3fj.apps.googleusercontent.com',
  );

  GoogleService();

  Future<UserModel?> signInWithGoogle() async {
    try {
      await _init;
      final googleUser = await googleSignIn.authenticate();
      return await _signIn(googleUser);
    } catch (_) {
      return null;
    }
  }

  Future<UserModel?> signInSilently() async {
    try {
      await _init;
      final Future<GoogleSignInAccount?>? attempt = googleSignIn
          .attemptLightweightAuthentication();
      if (attempt == null) return null;
      final googleUser = await attempt;
      return googleUser != null ? await _signIn(googleUser) : null;
    } catch (_) {
      return null;
    }
  }

  Future<UserModel?> _signIn(GoogleSignInAccount googleUser) async {
    try {
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = fb.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);
      return _getFirebaseAuthUser();
    } catch (_) {
      return null;
    }
  }

  UserModel? _getFirebaseAuthUser() {
    fb.User? user = auth.currentUser;
    if (user == null) return null;

    return UserModel(
      id: user.uid,
      name: user.displayName ?? "",
      email: user.email ?? "",
    );
  }
}
