import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  String time;
  String flag;
  String url;
  bool isDaytime;
  int minu = 0;
  WorldTime({this.location, this.flag, this.url});
  
  Future<void> getTime() async{
    if(this.location == 'Kolkata'){
      minu = 30;
    }
    try{
    Response response = await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);
    // print(data);
    // print(data['datetime']);
    //get properties from data
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);
    // String offset2 = data['utc_offset'].substring(3,4);
    // print(datetime);
    // print(offset); 
    //create datetimie object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset),minutes: minu));
    // print(now);
    //set the time property
    isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
    time = DateFormat.jm().format(now);
  
    }
    catch (e){
      print('error caught $e');
      time = 'sorry';
    }

  }
  

}

WorldTime instance = WorldTime(location:'Kolkata',flag: 'india.png',url: 'Asia/Kolkata');