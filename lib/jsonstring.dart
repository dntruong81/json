import 'dart:convert';

void main() {
  String jsonString =
  '''[
      {
        "name": "A",
        "score":100
      },
        {
        "name": "B",
        "score": 90
      },
        {
        "name": "C",
        "score": 80
      }
     ]''';
  // Gia ma chuoi JSON ve  Object
    print(jsonString.runtimeType);
    var scores = jsonDecode(jsonString);
    print(scores.runtimeType);
    print(scores[2]['name']);
  // Ma hoa Objdc ve chuoi JSON
    Map<String,dynamic> jsonData = {'userId':1,'id':2,'title':'A'};
    String jsonText = jsonEncode(jsonData);
    print(jsonText);
    print('----------------');

  //print('${jsonData['userId']} + ${jsonData['id']} + ${jsonData['title']} ');

  // Tao 1 doi tuong Event tu mot JSON
  Event event = Event.formJson(jsonData);
  // In ra mot doi tuong Even
  print('${event.userId} + ${event.id} + ${event.title}');

  //Dua 1 doi tuong Event sang JSON
  var json = event.toJson();
  print(json.runtimeType);
  String jsonString1 = jsonEncode(json);
  print(jsonString1);

}
class Event{
  late int userId;
  late int id;
  late String title;
  Event(this.userId,this.id,this.title);

  Event.formJson(Map<String,dynamic> json){
    userId = json["userId"];
    id = json["id"];
    title = json["title"];
  }

  Map<String,dynamic> toJson(){
    return(
    {
      'userId': this.userId,
      'id': this.id,
      'title': this.title
    }
    );
  }
}
