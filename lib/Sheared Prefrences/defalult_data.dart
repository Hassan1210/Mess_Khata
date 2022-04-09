import 'package:mess_khata/DB Helper/db_helper.dart';
import 'package:mess_khata/Time_Table/time_modle.dart';

ModleTimeTable _modleTimeTable = ModleTimeTable();

class DefaultData {
  List<String> days = [
    'Saturday',
    'Sunday',
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];
  List<String> dinners = [
    "Daal",
    "Chany",
    "Chawal",
    "Sabzi",
    "Haleem",
    "Surprise",
    "Kima"
  ];
  List<String> lunch = [
    "Kima",
    "Chines Rice",
    "Korma",
    "Broast",
    "Baryani",
    "Alo Goshat",
    "Baryani",
  ];
  List<int> dinnersRate = [80, 80, 90, 80, 80, 140, 80];
  List<int> lunchRate = [80, 100, 100, 120, 120, 100, 120];

  Dbhelper dbhelper = Dbhelper.intance;
  void insert() async {
    for (int i = 0; i <= 6; i++) {
        _modleTimeTable.id = i;
        _modleTimeTable.day = days[i];
        _modleTimeTable.lunch = lunch[i];
        _modleTimeTable.dinner = dinners[i];
        _modleTimeTable.lunchRs =lunchRate[i];
        _modleTimeTable.dinnerRs = dinnersRate[i];
      final id = await dbhelper.insert(_modleTimeTable);
      print(id);
    }
  }
}
