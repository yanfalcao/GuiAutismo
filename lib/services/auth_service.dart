import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guiautismo/blocs/user_bloc.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  static loginWithfacebook({@required Function successComplete}) async {
    final fb = FacebookLogin();

    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:

        final FacebookAccessToken accessToken = res.accessToken;
        final AuthCredential authCredential =
            FacebookAuthProvider.credential(accessToken.token);
        final result = await FirebaseAuth.instance
            .signInWithCredential(authCredential)
            .then((userCredencial) {
              final userBloc = BlocProvider.getBloc<UserBloc>();
              userBloc.inUser.add(userCredencial.user);
              successComplete.call();
            });

        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        print('Error while log in: ${res.error}');
        break;
    }
  }

  static loginWithGoogle({@required Function successComplete}) async {
    final googleSignIn = GoogleSignIn();
    final user = await googleSignIn.signIn();

    if(user != null){
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );

      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((userCredencial) {
            final userBloc = BlocProvider.getBloc<UserBloc>();
            userBloc.inUser.add(userCredencial.user);
            successComplete.call();
          });
    }
  }

  static logout() async {
    if(await (GoogleSignIn()).isSignedIn())
      await (GoogleSignIn()).disconnect();
    if(await (FacebookLogin()).isLoggedIn)
      await (FacebookLogin()).logOut();

    FirebaseAuth.instance.signOut();
  }

  authCheck({@required UserBloc bloc}) async {
    await _auth.authStateChanges().listen(
      (User user) {
        bloc.inUser.add(user ?? null);
      },
      onError: (err) {
        print('Error: $err');
        bloc.inUser.add(null);
      }
    );
  }
}