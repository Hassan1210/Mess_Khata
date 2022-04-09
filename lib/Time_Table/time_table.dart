import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors
import 'package:mess_khata/DB Helper/db_helper.dart';
import 'alert_box.dart';

var myitem = [];
List<DataRow> child = [];

class TimeTable extends StatefulWidget {
  const TimeTable({Key? key}) : super(key: key);

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Dbhelper dbhelper = Dbhelper.intance;
  read() async {
    child = [];
    myitem = [];
    var rows = await dbhelper.readTimeTable();
    rows.forEach((row) {
      myitem.add(row.toString());
      child.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text(row['day'].toString())),
            DataCell(Text(row['lunch'].toString())),
            DataCell(Text(row['dinner'].toString())),
            DataCell(Text(''), showEditIcon: true, onTap: () {
              print(row['lunch_Rs'].toString(),);
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) {
                    return MyDialog(
                      id: row['id'],
                      lunchName:row['lunch'].toString(),
                      lunchRs: row['lunch_Rs'].toString(),
                      dinnerName: row['dinner'].toString(),
                      dinnerRs: row['dinner_RS'].toString(),
                      day: row['day'].toString(),
                    );
                  });
            }),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: Text("Time Table"),
          titleTextStyle: TextStyle(
              color: Theme.of(context).iconTheme.color,
              fontWeight: FontWeight.bold,
              fontSize: 20),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Scaffold(
            body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FutureBuilder(
                      future: read(), // async work
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Column(
                              children: const[
                                SizedBox(
                                  height: 180,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                    child: CircularProgressIndicator())
                              ],
                            );
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return DataTable(
                                  dividerThickness: 1.5,
                                  columnSpacing: 40,
                                  dataTextStyle: TextStyle(
                                      color: Theme.of(context).iconTheme.color,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  headingTextStyle: TextStyle(
                                      color: Theme.of(context).iconTheme.color,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  headingRowHeight: 75,
                                  dataRowHeight: 65,
                                  columns: const <DataColumn>[
                                    DataColumn(label: Text('Day')),
                                    DataColumn(label: Text('Lunch')),
                                    DataColumn(label: Text('Dinner')),
                                    DataColumn(label: Text('Edit')),
                                  ],
                                  rows: child);
                            }
                        }
                      },
                    )))));
  }
}
