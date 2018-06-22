import 'package:flutter/material.dart';
import 'package:talkpal/talkpal.dart';

class ExampleCard extends StatelessWidget
{
  final Event event;
  ExampleCard(this.event);

  @override
  Widget build(BuildContext context)=>  
          Container(
                margin: new EdgeInsets.only(bottom: 32.0),
                child:
    Material(
      elevation: 8.0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0), 
          topRight: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0)
        ),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child:      
              Container(
               
                padding: const EdgeInsets.all(32.0),
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    begin: const Alignment(0.0, -1.0),
                    end: const Alignment(0.0, 0.6),
                    colors: <Color>[
                      const Color(0x00ef5350),
                      Colors.red[500]
                    ],
                  ),
                ),
                child: new Row(
                  children: [
                    new Expanded(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Container(
                             
                            // padding: const EdgeInsets.only(bottom: 8.0),
                            child: new Text(
                              'Oeschinen Lake Campground ${event.name}',
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          new Text(
                            'Kandersteg, Switzerland',
                            style: new TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Icon(
                      Icons.star,
                      color: Colors.red[500],
                    ),
                    new Text('41'),
                  ],
              )
              )
          ),
        ],
      ),
      )
    );
      // Container( // grey box
      //   child: new Stack(
      //     children: [
      //       new Positioned( // red box
      //         child:  new Container(
      //           child: new Text(
      //             "Lorem ipsum",
      //           ),
      //           decoration: new BoxDecoration(
      //             color: Colors.red[400],
      //           ),
      //           padding: new EdgeInsets.all(16.0),
      //         ),
      //         left: 24.0,
      //         top: 24.0,
      //       ),
      //     ],
      //   ), 
      //   width: 320.0,
      //   height: 240.0,
      //   color: Colors.amber.shade300,
      // );


}