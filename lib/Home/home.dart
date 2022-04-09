import 'package:flutter/material.dart';
import 'package:mess_khata/DB%20Helper/db_helper.dart';
import 'package:mess_khata/app_bar/app_bar.dart';
import 'package:intl/intl.dart';
// ignore_for_file: prefer_const_constructors
import 'package:mess_khata/app_bar/mytheme.dart';
import 'package:provider/provider.dart';
import 'buttons.dart';
import 'date_time_line.dart';
import 'cards.dart';
import 'package:mess_khata/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mess_khata/Time_Table/time_modle.dart';

String? lunchTime;
String? dinnerTime;
String? dinner;
String? lunch;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
            children: [
          App_Bar(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isLight
                            ? Colors.grey[400]
                            : Colors.grey[500],
                      ),
                    ),
                    Text(
                      "Today",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ],
                ),
                AddButton()
              ],
            ),
          ),
          TimeLine(),
        ]),
      ),
    );
  }
}
