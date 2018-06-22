import 'package:flutter/material.dart';
import 'package:talkpal/talkpal.dart';

class TestCard extends StatelessWidget
{
  final Event event;
  TestCard(this.event);

  @override
  Widget build(BuildContext context)=>  
        Padding
        (
          padding: EdgeInsets.only(bottom: 16.0),
          child: Align
          (
            alignment: Alignment.topCenter,
            child: SizedBox.fromSize
            (
              size: Size.fromHeight(172.0),
              child: Stack
              (
                fit: StackFit.expand,
                children: <Widget>
                [
                  /// Item description inside a material
                  Container
                  (
                    margin: EdgeInsets.only(top: 24.0),
                    child: Material
                    (
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(12.0),
                      shadowColor: Color(0x802196F3),
                      color: Colors.white,
                      child: Padding
                      (
                        padding: EdgeInsets.all(24.0),
                        child: Column
                        (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>
                          [
                            /// Title and rating
                            Column
                            (
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>
                              [
                                Text('${event.name}', style: TextStyle(color: Colors.blueAccent)),
                                Row
                                (
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>
                                  [
                                    Text('No reviews', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                                  ],
                                ),
                              ],
                            ),
                            /// Infos
                            Row
                            (
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>
                              [
                                Text('Bought', style: TextStyle()),
                                Padding
                                (
                                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Text('0', style: TextStyle(fontWeight: FontWeight.w700)),
                                ),
                                Text('times for a profit of', style: TextStyle()),
                                Padding
                                (
                                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Material
                                  (
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.green,
                                    child: Padding
                                    (
                                      padding: EdgeInsets.all(4.0),
                                      child: Text('\$ 0', style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  /// Item image
                  Align
                  (
                    alignment: Alignment.topRight,
                    child: Padding
                    (
                      padding: EdgeInsets.only(right: 16.0),
                      child: SizedBox.fromSize
                      (
                        size: Size.fromRadius(54.0),
                        child: Material
                        (
                          elevation: 20.0,
                          shadowColor: Color(0x802196F3),
                          shape: CircleBorder(),
                          child: Image.asset('res/shoes1.png'),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          ),
        );      
}