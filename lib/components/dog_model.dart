import 'dart:async';
import 'dart:math';
import 'package:talkpal/models/event.dart';

class Dog {
  final String name;
  final int count;
  final String location;
  final String description;
  String imageUrl;
  int rating = 10;

  Dog(this.count, this.name, this.location, this.description);

  Future getImageUrl() async {
    if (imageUrl != null) {
      return;
    }
    // Get an Image
    // HttpClient http = new HttpClient();
    try {
      // var uri = new Uri.http('dog.ceo', '/api/breeds/image/random');    
      int next = Random().nextInt(255);
      var uri = new Uri.https("picsum.photos", "400",{'random':'$next'});    
      imageUrl = uri.toString();
      // print("$imageUrl");

      // var request = await http.getUrl(uri);
      // HttpClientResponse response = await request.close();
      
      // print("redirect ${response.isRedirect}");
      
      // var responseBody = await response.transform(UTF8.decoder).join();
      //         print("uri $responseBody");
      // var json = JSON.decode(responseBody);
      // var url = json['message'];
      // imageUrl = url;
    } catch (exception) {
      print(exception);
    }
  }
}