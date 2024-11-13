import 'dart:convert';
void main() {
  String jsonString =
  '''[{
        "userId": 1,
        "id":1,
        "title":"A"
      },
         {
          "userId": 2,
          "id":2,
          "title":"B"
      },
      {
        "userId":3,
        "id":3,
        "title":"C"
      }
     ]''';
  //Giai ma chuoi json thanh danh sach cac json
  var jsonDatas = jsonDecode(jsonString);
  print(jsonDatas.runtimeType);//Ket qua la danh sach cac json
  //Lay mot json: la phan tu cua List json
  Map<String,dynamic> jsonData = jsonDatas[0];
  print(jsonData.runtimeType);
  //Tao mot doi tuong Oject event tu mot json
  Event event = Event.formJson(jsonData);
  print(event.runtimeType); //ket qua la kieu Oject: Event
  //Tao mot json tu Object: EVent
  Map<String,dynamic> json = event.toJson();
  print(json.runtimeType); //ket qua la kieu json

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
