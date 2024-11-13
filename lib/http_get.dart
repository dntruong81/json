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
              future: fetchData('https://jsonplaceholder.typicode.com/posts'),
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

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: jsonData.length,
                      itemBuilder: (BuildContext context, int i) {
                        //Tao mot doi tuong tu json
                        Event event = Event.formJson(jsonData[i]);
                        return Card(
                            child: Text(
                                'UserID: ${event.userId}, id: ${event.id}, title: ${event.title}, body: ${event.body}'));
                      });
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
  late String body;

  Event(this.userId, this.id, this.title, this.body);

  Event.formJson(Map<String, dynamic> json) {
    userId = json["userId"];
    id = json["id"];
    title = json["title"];
    body = json["body"];
  }

  Map<String, dynamic> toJson() {
    return ({
      "userId": this.userId,
      "id": this.id,
      "title": this.title,
      "body": this.body
    });
  }
}

Future<String> fetchData(String urlString) async {
  Uri url = Uri.parse(urlString);
  var response = await http.get(url);
  return (response.body);
}

