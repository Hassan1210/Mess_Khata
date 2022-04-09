import 'package:flutter/material.dart';
import 'package:mess_khata/App_Bar/botom_bar.dart';
import 'package:mess_khata/Home/cards.dart';
import 'package:mess_khata/app_bar/mytheme.dart';
import 'package:provider/provider.dart';
// ignore_for_file: prefer_const_constructors
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mess_khata/Sheared Prefrences/defalult_data.dart';
import 'package:intl/intl.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? id = prefs.getInt("first_time");
  print(id);
  if( id != 1)
    {
      DefaultData().insert();
      prefs.setInt("first_time", 1);
      prefs.setString("lunch",DateFormat.jm().format(DateTime(0,0,0,12,0)));
      prefs.setString("dinner",DateFormat.jm().format(DateTime(0,0,0,18,0)));

    }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_)=>ThemeProvider()),
        ChangeNotifierProvider(create:(_)=>CardChanges()),

      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: themeProvider.theme,
              theme: MyTheme.themeLight,
              darkTheme: MyTheme.themeDark,
              home: Bottom(current: 0,)
          );
  }
}


//
// var date = DateTime.now();
// var prevMonth = DateTime(date.year, date.month - 1, date.day);
// DateTime lastDayCurrentMonth = DateTime.utc(DateTime.now().year,prevMonth.month+1,).subtract(Duration(days: 1));
// DateTime firstDayCurrentMonth = DateTime.utc(DateTime.now().year, prevMonth.month, 1);
// print(lastDayCurrentMonth);
// print(firstDayCurrentMonth);
// String s = DateTime.now().toString();
// print(DateFormat('dd-MM-yyyy').format(DateTime.parse(s)));
// //print(DateFormat.EEEE().format(DateTime.parse(s.toString())));