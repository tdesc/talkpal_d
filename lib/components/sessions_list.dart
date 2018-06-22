import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:talkpal/talkpal.dart';
import 'package:built_redux/built_redux.dart';
import 'package:built_collection/built_collection.dart';

import 'package:async/async.dart' show StreamGroup;

import 'package:flutter_built_redux/flutter_built_redux.dart';
import '../components/dog_card.dart';

import 'dog_model.dart';


class SessionsList extends StoreConnector<AppState, AppActions, AppState>{

  SessionsList();

  @override 
  AppState connect(AppState state)=>state;

  @override
  Widget build(BuildContext context, AppState state, AppActions actions ) {

      print("#Sessions count ${state.sessions.map.length}");
  
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("${state.user.name}"),
        ),
          body:   
            Column(
              children: <Widget>[                  
                Expanded(
                  
                  child: ListView.builder(
                    itemCount: state.sessions.map.length,
                    padding: EdgeInsets.all(8.0),
                    // padding: EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.vertical,
                    itemExtent: 140.0,
                    itemBuilder: (context, index) {
                       
                      final List<String> keys = state.sessions.map.keys.toList();
                      final Session session = state.sessions.map[keys[index]];
                      // return ExampleCard(event);
                      return DogCard(new Dog(session.participants.length,"111 ${session.title}", session.id, 'A Very Good Boy'));//EventCard(event);
                    }
                  )),
                  FlatButton(
                   child: const Text('Navigate'),
                    onPressed: () {
                      // Perform some action
                      actions.sessions.setCurrent("0hBg2mDWVSfAENQPxnb7");
                      Navigator.pushNamed(context, "/session");
                    },                                    
                ),                
              ],
            )

      );
             
    }                     
}