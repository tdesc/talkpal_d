
import 'dart:async';
import 'dart:math';

import 'package:async/async.dart' show StreamGroup;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:talkpal/talkpal.dart';
import 'package:built_redux/built_redux.dart';

class DatabaseRouter {

  DatabaseRouter(this.store);

  FirebaseUser user;
  final Store<AppState, AppStateBuilder, AppActions> store;

  List<Stream<QuerySnapshot>> subscriptions = new List();
  
  void subscribeEvents()
  {
      CollectionReference collection = Firestore.instance.collection('events');
      if( !store.state.user.loggedIn)
      {
        print("error subscribe without loggedIn user");
        return;
      }
      var uid = store.state.user.uid;
      print("subscribe /events with user $uid");


      Stream<QuerySnapshot> subscription = StreamGroup.merge([ 
         collection
        .where('owner.uid', isEqualTo: uid)
        .snapshots(),
        collection   
        .where('permissions.$uid', isEqualTo: true)
        .snapshots()             
        ]);
        
      this.subscriptions.add( subscription );

      subscription.listen((QuerySnapshot querySnapshot) {
        querySnapshot.documentChanges.forEach((change) {
          // Do something with change       
          if( change.type == DocumentChangeType.removed )
          {
              this.store.actions.events.remove(change.document.documentID);
          }
        }); 
        querySnapshot.documents.forEach((DocumentSnapshot ds){
                     
            if( ds.exists )
            {
              final Map<String, dynamic> data = ds.data;
              data['id'] = ds.documentID;              
              data['name'] ??= 'default title';
              
              var uri = new Uri.https("picsum.photos", "400",{'random':'${Random().nextInt(255)}'});  
              data['coverUrl'] ??= uri.toString();

              print("events data ${ data.toString()}");
            
              Event event = serializers.deserializeWith(Event.serializer,data);

              this.store.actions.events.update(event);
            }
         
          });
      });    
  }

  void subscribeSessions()
  {
      // store.actions.loginFirebase();

      CollectionReference collection = Firestore.instance.collection('sessions');
      if( !store.state.user.loggedIn)
      {
        print("error subscribe without loggedIn user");
        return;
      }
      var uid = store.state.user.uid;
       print("subscribe /sessions with user $uid");

      Stream<QuerySnapshot> subscription = collection   
        .where('participants.$uid.allowed', isEqualTo: true)
        .snapshots();
              
      this.subscriptions.add( subscription );

      subscription.listen((QuerySnapshot querySnapshot) {
        querySnapshot.documentChanges.forEach((change) {
          // Do something with change       
          if( change.type == DocumentChangeType.removed )
          {
            final Map<String, dynamic> data = change.document.data;

            this.store.actions.sessions.remove(Session((b)=>b
              ..id=change.document.documentID
              ..eventId=data['eventId']) );
          }
        }); 
        querySnapshot.documents.forEach((DocumentSnapshot ds){
            
            final Map<String, dynamic> data = ds.data;
            data['id'] = ds.documentID;
            data['title'] ??= 'default title';

            print("session data ${ data.toString()}");
            
            Session session = serializers.deserializeWith(Session.serializer,data);
            this.store.actions.sessions.update(session);
          });
      });    
  }

}