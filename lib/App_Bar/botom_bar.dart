import 'package:flutter/material.dart';
import 'package:mess_khata/Home/home.dart';
// ignore_for_file: prefer_const_constructors
import 'package:mess_khata/Time_Table/time_table.dart';
import 'package:mess_khata/History/history.dart';
import 'package:mess_khata/Settings/settings.dart';




class Bottom extends StatefulWidget {

  Bottom({required this.current});
  final int current;

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  final screen = [Home(),TimeTable(),History(),Setting()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    current = widget.current;
  }
  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 50,
        selectedItemColor: Theme.of(context).iconTheme.color,
        iconSize: 30,
        unselectedItemColor: Theme.of(context).iconTheme.color,
        currentIndex: current,
        onTap: (index)=>setState(() {
          current = index;
        }),
        items: [
           BottomNavigationBarItem(icon: current==0?Icon(Icons.home,size: 35,color:Theme.of(context).iconTheme.color,):Icon(Icons.home_outlined,size: 35,color:Theme.of(context).iconTheme.color,),
              label:'Home',
              backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(icon: current==1?Icon(Icons.history_rounded,size: 35,color:Theme.of(context).iconTheme.color,):Icon(Icons.history_toggle_off,size: 35,color:Theme.of(context).iconTheme.color,),
              label:'Time Table',
              backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(icon: current==2?Icon(Icons.insert_chart_rounded,size: 35,color:Theme.of(context).iconTheme.color,):Icon(Icons.stacked_line_chart,size: 35,color:Theme.of(context).iconTheme.color,),
              label:'History',
              backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(icon: current==3?Icon(Icons.settings,size: 35,color:Theme.of(context).iconTheme.color,):Icon(Icons.settings_outlined,size: 35,color:Theme.of(context).iconTheme.color,),
              label:'Setting',
              backgroundColor: Colors.red
          ),
        ],
      ),
      body:screen[current] ,
    );
  }
}

