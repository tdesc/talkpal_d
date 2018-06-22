import 'package:flutter/material.dart';
import 'package:talkpal/talkpal.dart';
import 'package:talkpal_d/widgets/session_room.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

class ActiveSession extends StoreConnector<AppState, AppActions, Sessions>{

  ActiveSession();

  @override 
  Sessions connect(AppState state){
    
    return state.sessions;
  }

  @override
    Widget build(BuildContext context, Sessions sessions, AppActions actions ) 
    =>SessionRoom(sessions.current);

}