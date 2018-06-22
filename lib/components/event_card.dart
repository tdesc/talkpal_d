import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'event_detail_page.dart';

import 'package:built_redux/built_redux.dart';
import 'package:talkpal/models/event.dart';



class EventCard extends StatefulWidget {
  final Event event;

  EventCard(this.event);

  @override
  EventCardState createState() {
    return new EventCardState(event);
  }
}

class EventCardState extends State<EventCard> {
  Event event;

  EventCardState(this.event);

  void initState() {
    super.initState();
  }

  Widget get eventCoverImage {
      
    var eventCover = new Hero(
      tag: event,
      child: new Container(
        width: 100.0,
        height: 100.0,
        decoration: new BoxDecoration(
          // shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: new NetworkImage(event.coverUrl),
          ),
        ),
      ),
    );

    var placeholder = new Container(
        width: 100.0,
        height: 100.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          gradient: new LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black54, Colors.black, Colors.blueGrey[600]],
          ),
        ),
        alignment: Alignment.center,
        child: new Text(
          'DOGGO',
          textAlign: TextAlign.center,
        ));

    var crossFade = new AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: eventCover,
      crossFadeState: event.coverUrl == null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: new Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  Widget get eventCard {
    return new Positioned(
      right: 0.0,
      child: new Container(
        width: 300.0,
        height: 180.0,
        child: new Card(
          color: Colors.white10,
          child: new Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 92.0,
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text(widget.event.name,
                    style: Theme.of(context).textTheme.headline),
                new Text(widget.event.location ?? 'default location',
                    style: Theme.of(context).textTheme.subhead),
                
                 new Row(
                  children: <Widget>[
                    FlatButton(
                      color: Colors.white,
                      textColor: Colors.purpleAccent,
                      child: Text('Action button'),
                      onPressed: () => print("hi!"),
                    ),
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () => showEventDetailPage(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: new Container(
          height: 145.0,
          child: new Stack(
            children: <Widget>[
              eventCard,
              new Positioned(top: 7.5, child: eventCoverImage),
            ],
          ),
        ),
      ),
    );
  }

  showEventDetailPage() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new EventDetailPage(event);
    }));
  }
}