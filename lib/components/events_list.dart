import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:talkpal/talkpal.dart';
import 'package:talkpal/models/event.dart';

import 'package:built_redux/built_redux.dart';
import 'package:built_collection/built_collection.dart';

import 'package:async/async.dart' show StreamGroup;

import 'package:flutter_built_redux/flutter_built_redux.dart';
import '../components/event_card.dart';
import '../components/test_card.dart';
import '../components/dog_card.dart';
import '../components/example_card.dart';

import 'dog_model.dart';


class EventsList extends StoreConnector<AppState, AppActions, AppState>{

  EventsList();

  @override 
  AppState connect(AppState state)=>state;

  @override
  Widget build(BuildContext context, AppState state, AppActions actions ) {

      // print("events count ${state.events.length}");

      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Hellowww 111"),
        ),
          floatingActionButton: buildActionButton(context),
          body:   
            Column(
              children: <Widget>[                  
                Expanded(
                  
                  child: ListView.builder(
                    itemCount: state.events.map.length,
                    padding: EdgeInsets.all(8.0),
                    // padding: EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.vertical,
                    itemExtent: 160.0,
                    itemBuilder: (context, index) {
                       
                      final List<String> keys = state.events.map.keys.toList();
                      final Event event = state.events.map[keys[index]];
                      // return ExampleCard(event);
                      // return Text("${event.name} id:${event.id} sessions:${event.sessions.length}");
                      return EventCard(event);//EventCard(event);
                    }
                  )),
                  FlatButton(
                   child: const Text('Navigate'),
                    onPressed: () {
                      // Perform some action
                   
                    },
                  ),

                  FlatButton(
                   child: const Text('Request event'),
                    onPressed: () {
                      // Perform some action
                      // actions.newEventAction(EventRequest((b)=>b
                      //   ..uid = state.user.uid
                      //   ..type = "create"                      
                      //   ..payload.title = "payload title")
                      // );
                    },
                  ),
                            
              ],
            )

      );
          // ListView.builder(
          //       itemCount: 2,
          //       padding: const EdgeInsets.only(top: 10.0),
          //       itemExtent: 25.0,
          //       itemBuilder: (context, index) {

          //           print("events builder ${events}");

          //         return new Text(" s $index");
          //       }
          //     ) 


              
    }
    
    Widget buildActionButton(context) {
     return FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
             Navigator.pushNamed(context, "/create_event");
          },
      );
  }                     
}