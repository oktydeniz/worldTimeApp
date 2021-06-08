import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  //when func over return or bring something
  //This word says this func bring object in the future (like promises in javaScript)
  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map map = jsonDecode(response.body);

      String dateTime = map['datetime'];
      String offset = map['utc_offset'].substring(0, 3);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Error : $e');
      time = 'could not get time data';
    }
  }
}
