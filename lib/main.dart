import 'package:flutter/material.dart';
import 'package:talkpal/talkpal.dart';
import 'package:built_redux/built_redux.dart';

import 'package:talkpal_d/middleware/login.dart';
import 'package:talkpal/middleware/events.dart';
// import 'package:talkpal_d/middleware/navigation.dart';
import 'dart:async';

import 'firebase.dart';
import 'app/app_component.dart';

Future<void> main() async {

  final store = Store<AppState, AppStateBuilder, AppActions>(
    reducerBuilder.build(), // build returns a reducer function
    AppState(),
    AppActions(),
    middleware: [
      loginMiddlewareBuilder.build(),
    //  loggingMiddleware,
      // navigationMiddlewareBuilder.build(),
      createEventsMiddleware().build()
    ],
  );
  final databaseRouter = DatabaseRouter(store);

  runApp(AppComponent(store,databaseRouter));
}
  