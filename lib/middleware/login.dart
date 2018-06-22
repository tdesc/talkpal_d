import 'dart:async';
import 'package:built_redux/built_redux.dart';

import 'package:talkpal/talkpal.dart';

export 'package:talkpal/models/user.dart' show User;


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

final loginMiddlewareBuilder = new MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
  ..add(AppActionsNames.loginFirebase, loginFirebase)
  ..add(AppActionsNames.loginSuccess, loginSuccess);


Future<Null> _handleSignIn() async {
  try {
    await _googleSignIn.signIn();
  } catch (error) {
    print(error);
  }
}


void loginFirebase(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next, Action<Null> action) async {
  next(action);
  print("#loginFirebase ");
  
  FirebaseUser user;
  // if( !api.state.isLoggedIn )
  {
      GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
    
      user = await FirebaseAuth.instance.signInWithGoogle(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
  }
  print("user $user");
  // else 
  // {
  //   user = await FirebaseAuth.instance.signInAnonymously();
  // }

  final Map<String, dynamic> data = Map<String, dynamic>();
              data['loggedIn'] = true;
              data['uid'] = user.uid;              
              data['name'] = user.displayName;
              data['photoUrl'] = user.photoUrl;
            
              print("User data ${ data.toString()}");
            
  User loggedUser = serializers.deserializeWith(User.serializer,data);
  api.actions.loginSuccess(loggedUser);
}

void loginSuccess(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next, Action<User> action) async {
  next(action);
  print("#loginSuccess ${action.payload}");

}
