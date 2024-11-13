import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JsonTest(),
    );
  }
}

class JsonTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return JsonTestStage();
  }
}

class JsonTestStage extends State<JsonTest> {
  String? _kq;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Json test'),
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: FutureBuilder(
              future: makePostData('https://jsonplaceholder.typicode.com/albums'),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text('Co loi: ${snapshot.hasError}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  String jsonString = snapshot.data;
                  //Giai ma chuoi tren thanh mot json
                  var jsonData = jsonDecode(jsonString);

                  Event event = Event.formJson(jsonData);

                  return  Card(child: Text('UserID: ${event.userId}, id: ${event.id}, title: ${event.title}'));

                }
                return Container(
                  child: Text("done"),
                );
              })),
    );
  }
}

class Event {
  late int userId;
  late int id;
  late String title;

  Event(this.userId, this.id, this.title);

  Event.formJson(Map<String, dynamic> json) {
    userId = json["userId"];
    id = json["id"];
    title = json["title"];
  }

  Map<String, dynamic> toJson() {
    return ({
      "userId": this.userId,
      "id": this.id,
      "title": this.title,
    });
  }
}

Future<String> fetchData(String urlString) async {
  Uri url = Uri.parse(urlString);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    return (response.body);
  } else
    return ('Co loi xay ra');
}

Future<String> makePostData(String urlString) async {
  // cài đặt tham số POST request
  Uri url = Uri.parse(urlString);
  // tạo POST request
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': 'Hello',
        'userId': 1
      })
  );
  if (response.statusCode == 201)
    return (response.body);
  else
    throw Exception('Failed to create album.');
}
