
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OAuth{
  Future<UserCredential> signInWithGoogle() async{
    GoogleSignInAccount? googleUser=await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth= await googleUser?.authentication;
    OAuthCredential cred= GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      return FirebaseAuth.instance.signInWithCredential(cred);
  }
}