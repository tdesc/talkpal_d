
import 'package:flutter/material.dart';
import 'dart:math';
import '../components/events_list.dart';
import '../components/sessions_list.dart';
import '../components/participants_list.dart';
import '../components/active_session.dart';
import '../components/create_event.dart';

import '../firebase.dart';

import 'package:talkpal/talkpal.dart';
import 'package:built_redux/built_redux.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

class AppComponent extends StatefulWidget {
  
  AppComponent(this.store, this.databaseRouter);
  
  final Store<AppState, AppStateBuilder, AppActions> store;
  final DatabaseRouter databaseRouter;

  @override
  State createState() {
    print("Welcome to the Show!");
    store.actions.loginFirebase();

    store.actionStream(AppActionsNames.loginSuccess).listen((change) {
      
      print('Action: ${change.action.name}');
      databaseRouter.subscribeEvents(); 
      databaseRouter.subscribeSessions();
    });

    return new AppComponentState(store);
  }
}

class AppComponentState extends State<AppComponent> {

  AppComponentState(this.store);

  final Store<AppState, AppStateBuilder, AppActions> store;

  @override
  Widget build(BuildContext context) {
          
    return ReduxProvider(
        store: store,
        child: 
          MaterialApp(
            title: 'Talkpal',
            theme: new ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: EventsList(),
            routes: <String, WidgetBuilder> {
              '/home': (BuildContext context) => EventsList(),
              '/sessions': (BuildContext context) => SessionsList(),
              '/create_event': (BuildContext context) => CreateEventPage(title: "Create event", coverUrl: Uri.https("picsum.photos", "400",{'random':'${Random().nextInt(255)}'}).toString()),
              '/participants': (BuildContext context) => ParticipantsList(),
              '/session': (BuildContext context) => ActiveSession(),
            },
          )
    );
  }
}

