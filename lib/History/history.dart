import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mess_khata/DB%20Helper/db_helper.dart';
import 'package:mess_khata/History/history_modle.dart';
// ignore_for_file: prefer_const_constructors

DateTime? endDate;
DateTime? startDate;
Future<List<ModleHistory?>>? list;
bool isSee = true;

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: Text("History"),
          titleTextStyle: TextStyle(
              color: Theme.of(context).iconTheme.color,
              fontWeight: FontWeight.bold,
              fontSize: 20),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: DatePicker(),
        ));
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  int bill = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSee = true;
    startDate = DateTime.utc(DateTime.now().year, DateTime.now().month, 1);
    endDate = DateTime.now();
    Dbhelper dbhelper = Dbhelper.intance;
    list = dbhelper.readHistory(startDate, endDate);
    getBill();
    setState(() {});
  }

  getBill() async {
    Dbhelper dbhelper = Dbhelper.intance;
    print(endDate);
    bill = await dbhelper.getBill(startDate, endDate);
    setState(() {});
  }

  Future<void> _endDate(BuildContext context) async {
    endDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022, 1),
        lastDate: DateTime.now());
    if (endDate != null) {
      Dbhelper dbhelper = Dbhelper.intance;
      list = dbhelper.readHistory(startDate, endDate);
      isSee = false;
      bill = 0;
      getBill();
      setState(() {});
    } else {
      endDate = DateTime.now();
    }
  }

  Future<void> _startDate(BuildContext context) async {
    startDate = await showDatePicker(
        context: context,
        initialDate: DateTime.utc(DateTime.now().year, DateTime.now().month, 1),
        firstDate: DateTime(2022, 1),
        lastDate: DateTime.now());
    print(startDate);
    if (startDate != null) {
      Dbhelper dbhelper = Dbhelper.intance;
      list = dbhelper.readHistory(startDate, endDate);
      getBill();
      isSee = false;
      bill = 0;
      setState(() {});
    } else {
      startDate = DateTime.utc(DateTime.now().year, DateTime.now().month, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    "From",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _startDate(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(left: 14, top: 4),
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          enabled: false,
                          autofocus: false,
                          cursorColor: Theme.of(context).iconTheme.color,
                          decoration: InputDecoration(
                            hintText: DateFormat('dd-MM-yyyy')
                                .format(DateTime.parse(startDate.toString())),
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            suffixIcon: Icon(
                              Icons.history_rounded,
                              color: Theme.of(context).iconTheme.color,
                              size: 25,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0,
                            )),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0,
                            )),
                          ),
                        ))
                      ],
                    ),
                  ),
                )
              ],
            )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    "To",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _endDate(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(left: 14, top: 4),
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.number,
                          autofocus: false,
                          cursorColor: Theme.of(context).iconTheme.color,
                          decoration: InputDecoration(
                            hintText: DateFormat('dd-MM-yyyy')
                                .format(DateTime.parse(endDate.toString())),
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            suffixIcon: Icon(
                              Icons.history_rounded,
                              color: Theme.of(context).iconTheme.color,
                              size: 25,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 0,
                            )),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 0,
                            )),
                          ),
                        ))
                      ],
                    ),
                  ),
                )
              ],
            )),
          ],
        ),
        FutureBuilder(
          future: list, // async work
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Column(
                  children: const[
                    SizedBox(
                      height: 180,
                    ),
                    Center(
                        child: CircularProgressIndicator())
                  ],
                );
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data == null || snapshot.data.length == 0) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 180,
                      ),
                      Center(
                          child: Text(
                        'No data found',
                        style: TextStyle(
                            color: (Theme.of(context).iconTheme.color)!),
                      )),
                    ],
                  );
                } else {
                  return table(snapshot.data);
                }
            }
          },
        ),
        SizedBox(
          height: 8,
        ),
        bill != 0
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Total Bill',
                      style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  SizedBox(
                    width: 30,
                  ),
                  Text(bill.toString(),
                      style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ],
              )
            : Text(''),
        SizedBox(
          height: 8,
        )
      ],
    );
  }

  table(List<ModleHistory> list1) {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
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
            columns: const[
              DataColumn(label: Text("Date")),
              DataColumn(label: Text("Day")),
              DataColumn(label: Text("Lunch Rs")),
              DataColumn(label: Text("Dinner Rs")),
            ],
            rows: list1
                .map((list) => DataRow(cells: [
                      DataCell(Text(DateFormat('dd-MM-yyyy')
                          .format(DateTime.parse(list.day.toString())))),
                      DataCell(Text(DateFormat.EEEE()
                          .format(DateTime.parse(list.day.toString()))
                          .toString())),
                      DataCell(Text(list.lunchRs.toString())),
                      DataCell(Text(list.dinnerRs.toString())),
                    ]))
                .toList(),
          ),
        ),
      ),
    );
  }
}
