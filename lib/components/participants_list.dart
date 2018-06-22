import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:talkpal/talkpal.dart';
import 'package:talkpal/models/participant.dart';

import 'package:built_redux/built_redux.dart';
import 'package:built_collection/built_collection.dart';

import 'package:async/async.dart' show StreamGroup;

import 'package:flutter_built_redux/flutter_built_redux.dart';
import '../components/dog_card.dart';

import 'dog_model.dart';

class ParticipantsList extends StoreConnector<AppState, AppActions, Sessions>{

  ParticipantsList();
  
  @override 
  Sessions connect(AppState state){
    
    return state.sessions;
  }

  @override
  Widget build(BuildContext context, Sessions sessions, AppActions actions ) {

      print("#current Session ${sessions.current}");
        
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("${sessions.currentUid}"),
        ),
          body:   
            Column(
              children: <Widget>[                  
                Expanded(
                  
                  child: ListView.builder(
                    itemCount: sessions.current.participants.length,
                    padding: EdgeInsets.all(8.0),
                    // padding: EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.vertical,
                    itemExtent: 140.0,
                    itemBuilder: (context, index) {
                       
                      final List<String> keys = sessions.current.participants.keys.toList();
                      final Participant participant = sessions.current.participants[keys[index]];
                      // return ExampleCard(event);
                      return DogCard(new Dog(participant.volume, "Participant ${participant.name}", participant.uid, 'A Very Good Boy'));//EventCard(event);
                    }
                  )),
                  FlatButton(
                   child: const Text('Navigate'),
                    onPressed: () {
                      // Perform some action
                      Navigator.pushNamed(context, "/home");
                    },                                    
                ),                
              ],
            )

      );
             
    }                     
}