import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore_for_file: prefer_const_constructors

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void getData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lunchTime = prefs.getString("lunch");
    dinnerTime = prefs.getString("dinner");
    setState(() {
    });
  }

  _selectLunchTime(BuildContext context) async {
    final  timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("lunch", DateFormat.jm().format(DateTime(0,0,0,timeOfDay.hour,timeOfDay.minute)));
      lunchTime = DateFormat.jm().format(DateTime(0,0,0,timeOfDay.hour,timeOfDay.minute));
      setState(() {
      });
    }
  }
  _selectDinnerTime(BuildContext context) async {
    final  timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("dinner", DateFormat.jm().format(DateTime(0,0,0,timeOfDay.hour,timeOfDay.minute)));
      dinnerTime = DateFormat.jm().format(DateTime(0,0,0,timeOfDay.hour,timeOfDay.minute));
      setState(() {
      });
    }
  }
  String? lunchTime;
  String? dinnerTime;
  var selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: Text("Setting"),
        titleTextStyle: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontWeight: FontWeight.bold,
            fontSize: 20),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(children: [
        Card(
          color: Theme.of(context).primaryColor,
          child: ListTile(
            title: Text(
              "Update Lunch Time",
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(lunchTime.toString(),style: TextStyle(color: Theme.of(context).iconTheme.color)),
          onTap: (){
              _selectLunchTime(context);
          },
          ),
        ),
        Card(
          color: Theme.of(context).primaryColor,
          child: ListTile(
            title: Text(
              "Update Dinner Time",
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(dinnerTime.toString(),style: TextStyle(color: Theme.of(context).iconTheme.color),),
            onTap: () {
              _selectDinnerTime(context);
            },
          ),
        )
      ]),
    ));
  }
}
