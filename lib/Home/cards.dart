import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore_for_file: prefer_const_constructors
import 'package:mess_khata/DB Helper/db_helper.dart';
import 'package:mess_khata/History/history_modle.dart';
import 'package:mess_khata/constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mess_khata/Time_Table/time_modle.dart';



class MealCards extends StatelessWidget {
  const MealCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [kBlueColor, kBlueColor.withOpacity(.4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
            height: 100,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lunch",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: [
                      Icon(
                        Icons.watch_later_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        " ${Provider.of<CardChanges>(context).lunchTime.toString()}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: 01),
                      ),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    DateFormat('dd-MM-yyyy').format(DateTime.parse(
                                Provider.of<CardChanges>(context)
                                    .date
                                    .toString())) ==
                            DateFormat('dd-MM-yyyy').format(
                                DateTime.parse(DateTime.now().toString()))
                        ? Text(
                            "Today's lunch is "
                            "${Provider.of<CardChanges>(context).lunch.toString()}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 01))
                        : Text(
                            "${DateFormat.EEEE().format(DateTime.parse(Provider.of<CardChanges>(context).date.toString().toString()))}'s lunch is "
                            "${Provider.of<CardChanges>(context).lunch.toString()}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 01))
                  ],
                ),
                Row(
                  children: [
                    VerticalDivider(
                      thickness: 2,
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Provider.of<CardChanges>(context).isTakenLunch == 1
                          ? Text("Added",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.w700))
                          : Text("Not Added",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.w700)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors:  [Colors.red, Colors.red.withOpacity(.5),],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
            height: 100,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dinner",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: [
                      Icon(
                        Icons.watch_later_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        " ${Provider.of<CardChanges>(context).dinnerTime.toString()}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: 01),
                      ),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    DateFormat('dd-MM-yyyy').format(DateTime.parse(
                                Provider.of<CardChanges>(context)
                                    .date
                                    .toString())) ==
                            DateFormat('dd-MM-yyyy').format(
                                DateTime.parse(DateTime.now().toString()))
                        ? Text(
                            "Today's Dinner is "
                            "${Provider.of<CardChanges>(context).dinner.toString()}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 01))
                        : Text(
                            "${DateFormat.EEEE().format(DateTime.parse(Provider.of<CardChanges>(context).date.toString().toString()))}'s Dinner is ${Provider.of<CardChanges>(context).dinner.toString()}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 01))
                  ],
                ),
                Row(
                  children: [
                    VerticalDivider(
                      thickness: 2,
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Provider.of<CardChanges>(context).isTakenDinner == 0
                          || Provider.of<CardChanges>(context).isTakenDinner == null
                          ? Text("Not Added",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.w700))
                          : Text("Added",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.w700)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CardChanges extends ChangeNotifier {
  String lunchTime = '...';
  String dinnerTime = '...';
  String dinner = '...';
  String lunch = '...';
  String date = DateTime.now().toString();
  int? isTakenDinner;
  int? isTakenLunch;

  getData(DateTime time) async {
    // Get Time
    date = time.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lunchTime = prefs.getString("lunch").toString();
    dinnerTime = prefs.getString("dinner").toString();

    ModleTimeTable _modleTimeTable = ModleTimeTable();
    Dbhelper dbhelper = Dbhelper.intance;
    _modleTimeTable = await dbhelper.getMealName(time);
    lunch = _modleTimeTable.lunch.toString();
    dinner = _modleTimeTable.dinner.toString();
    ModleHistory obj = ModleHistory();
    obj = await dbhelper.getStatus(time);
    isTakenDinner = obj.dinner;
    print(obj.dinner);
    isTakenLunch = obj.lunch;
    notifyListeners();
  }
}
// Text("Taken",
// style: TextStyle(color: Colors.white, fontSize: 15))
