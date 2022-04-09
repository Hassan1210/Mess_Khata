import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:mess_khata/constant.dart';
import 'package:provider/provider.dart';
import 'package:mess_khata/app_bar/mytheme.dart';
import 'cards.dart';
import 'package:mess_khata/DB Helper/db_helper.dart';

class TimeLine extends StatefulWidget {
  const TimeLine({Key? key}) : super(key: key);

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get() async {
    await Provider.of<CardChanges>(context, listen: false)
        .getData(DateTime.parse(DateTime.now().toString()));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Expanded(
      child: ListView(
        children: [
          Container(
            child: FlutterDatePickerTimeline(
              selectedItemTextStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              selectedItemBackgroundColor: kBlueColor,
              unselectedItemTextStyle: TextStyle(
                color: Theme.of(context).iconTheme.color,
                fontWeight: FontWeight.w600,
              ),
              unselectedItemBackgroundColor: Theme.of(context).primaryColor,
              startDate: DateTime.now().subtract(Duration(days: 1)),
              endDate: DateTime.now().add(Duration(days: 5)),
              initialSelectedDate: DateTime.now(),
              onSelectedDateChange: (dateTime) async {
                await Provider.of<CardChanges>(context, listen: false)
                    .getData(DateTime.parse(dateTime.toString()));
              },
            ),
          ),
          SizedBox(
              height: MediaQuery. of(context). size. height*.04),
          MealCards(),
          ExpanseCards(),
        ],
      ),
    );
  }
}

class ExpanseCards extends StatefulWidget {
  const ExpanseCards({Key? key}) : super(key: key);

  @override
  _ExpanseCardsState createState() => _ExpanseCardsState();
}

class _ExpanseCardsState extends State<ExpanseCards> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentBill = 0;
    lastBill = 0;
    getBillLast();
    getBill();
  }

  getBill() async {
    Dbhelper dbhelper = Dbhelper.intance;
    currentBill = await dbhelper.getBill(
        DateTime.utc(DateTime.now().year, DateTime.now().month, 1),
        DateTime.now());
    setState(() {});
  }

  getBillLast() async {
    var date = DateTime.now();
    var prevMonth = DateTime(date.year, date.month - 1, date.day);
    DateTime lastDayCurrentMonth = DateTime.utc(
      prevMonth.year,
      prevMonth.month + 1,
    ).subtract(Duration(days: 1));
    DateTime firstDayCurrentMonth =
        DateTime.utc(prevMonth.year, prevMonth.month, 1);

    Dbhelper dbhelper = Dbhelper.intance;
    lastBill =
        await dbhelper.getBill(firstDayCurrentMonth, lastDayCurrentMonth);
    print(lastDayCurrentMonth);
    print(firstDayCurrentMonth);
    setState(() {});
  }

  int currentBill = 0;
  int lastBill = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height : MediaQuery. of(context). size. height*.035,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: const [kBlueColor, Color(0xFF00CCFF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text("This Month Expense",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Rs. ${currentBill.toString()}/-",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      SizedBox(
                        height: 10,
                      ),
                      Text("only",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20))
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.red,
                        Colors.red.withOpacity(.5),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      color: kBlueColor,
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text("Last Month Expense",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Rs. ${lastBill.toString()}/-",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      SizedBox(
                        height: 10,
                      ),
                      Text("only",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
