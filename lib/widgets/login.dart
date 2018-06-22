import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart' show StreamGroup;
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = new GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);


class LoginScreen extends StatefulWidget {
  @override
  State createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {

      }
    });
    _googleSignIn.signInSilently();
  }

 Future<Null> _testFirebase() async {

  // user = await FirebaseAuth.instance.currentUser();
  // print("#firebaseUser currentUser ${ user.toString()}");

  // await FirebaseAuth.instance.signOut();
  // print("#firebaseUser signedout");
  
  FirebaseUser user;

  try{
    if( _currentUser!=null )
    {
       GoogleSignInAuthentication googleAuth = await _currentUser.authentication;
    
      user = await FirebaseAuth.instance.signInWithGoogle(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
    }else
    {
      user = await FirebaseAuth.instance.signInAnonymously();
    }
   

    print("#firebaseUser anonymous ${ user.toString()}");
    
    // CollectionReference events = Firestore.instance.collection('events');
        
        // events
        // .where('owner.uid', isEqualTo: true)
        // .where('permissions.uid', isEqualTo: true)      
        // .snapshots().listen((QuerySnapshot querySnapshot) {
        //   querySnapshot.documents.forEach((DocumentSnapshot ds){
        //     final Map<String, dynamic> data = ds.data;
        //     print("data ${ data.toString()}");
        //   });
        // });
      // final String uid = user.uid;

      // StreamGroup.merge([ 
      //    events
      //   .where('owner.uid', isEqualTo: uid)
      //   .snapshots(),
      //   events   
      //   // .where('permissions.${user.uid}', isEqualTo: true)
      //   .where('permissions.$uid', isEqualTo: true)
      //   .snapshots()             
      //   ]).listen((QuerySnapshot querySnapshot) {
      //     querySnapshot.documents.forEach((DocumentSnapshot ds){
      //       final Map<String, dynamic> data = ds.data;
      //       print("data ${ data.toString()}");
      //     });
      //   });
   
  }catch(e)
  {
    print(" ${ e.toString()}");
  }
  
 }
  Future<Null> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<Null> _handleSignOut() async {
    _googleSignIn.disconnect();
  }

  Widget _buildBody() {
    if (_currentUser != null) {
      return new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new ListTile(
            leading: new GoogleUserCircleAvatar(
              identity: _currentUser,
            ),
            title: new Text(_currentUser.displayName),
            subtitle: new Text(_currentUser.email),
          ),
          const Text("Signed in successfully."),
          new RaisedButton(
            child: const Text('Firebase action'),
            onPressed: _testFirebase,
          ),
          new RaisedButton(
            child: const Text('SIGN OUT'),
            onPressed: _handleSignOut,
          ),     
        ],
      );
    } else {
      return new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text("You are not currently signed in."),
          new RaisedButton(
            child: const Text('Firebase action'),
            onPressed: _testFirebase,
          ),
          new RaisedButton(
            child: const Text('SIGN IN'),
            onPressed: _handleSignIn,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('Google Sign In'),
        ),
        body: new ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}