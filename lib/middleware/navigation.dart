import 'package:flutter/material.dart';

import 'package:built_redux/built_redux.dart';

import 'package:talkpal/actions/actions.dart';
import 'package:talkpal/states/application.dart';

import 'package:talkpal_d/widgets/login.dart';
import 'package:talkpal_d/widgets/navigation.dart';

final navigationMiddlewareBuilder = new MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
  ..add(AppActionsNames.startLoginFlow, startLoginFlow);

void startLoginFlow(MiddlewareApi<AppState, AppStateBuilder, AppActions> api, ActionHandler next, Action<dynamic> action) async {
  next(action);
  print("#startLoginFlow ");

  //   Navigator.push(
  //   action.payload, //context
  //   new MaterialPageRoute(
  //     builder: (context) => 
  //       new EventsList( Navigation.of(context).store ))
  // );
  
}

