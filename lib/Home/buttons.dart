import 'package:flutter/material.dart';
import 'package:mess_khata/constant.dart';
import 'package:mess_khata/DB Helper/db_helper.dart';
import 'package:mess_khata/History/history_modle.dart';
import 'package:mess_khata/Time_Table/time_modle.dart';
// ignore_for_file: prefer_const_constructors
import 'package:google_fonts/google_fonts.dart';
import 'package:mess_khata/App_Bar/botom_bar.dart';

int quantity = 1;

class AddButton extends StatefulWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantity = 1;
    checkStatus();
  }

  int? isLunch;
  int? isDinner;
  void checkStatus() async {
    Dbhelper dbhelper = Dbhelper.intance;
    ModleHistory obj = ModleHistory();
    obj = await dbhelper.getStatus(DateTime.now());

    isLunch = obj.lunch;
    isDinner = obj.dinner;
    print("$isLunch,$isDinner");
  }

  Dbhelper dbhelper = Dbhelper.intance;
  void insertLunch() async {
    ModleTimeTable _obj = ModleTimeTable();
    Dbhelper dbhelper = Dbhelper.intance;

    print(await dbhelper.checkStatus(DateTime.now()));

    if (await dbhelper.checkStatus(DateTime.now()) == true) {
      _obj = await dbhelper.getMealName(DateTime.now());

      ModleHistory _modleTimeTable = ModleHistory();
      _modleTimeTable.day = DateTime.now().toString();
      _modleTimeTable.lunch = 1;
      _modleTimeTable.dinner = 0;
      _modleTimeTable.lunchRs = (quantity * int.parse(_obj.lunchRs.toString()));
      _modleTimeTable.dinnerRs = 0;
      var id = await dbhelper.insertmeal(_modleTimeTable);
      print(id);
    } else {
      _obj = await dbhelper.getMealName(DateTime.now());

      ModleHistory _modleTimeTable = ModleHistory();
      _modleTimeTable.day = DateTime.now().toString();
      _modleTimeTable.lunch = 1;
      _modleTimeTable.lunchRs = (quantity * int.parse(_obj.lunchRs.toString()));
      var id = await dbhelper.updateLunch(_modleTimeTable);
    }
  }
  void insertLunchNo() async {
    ModleTimeTable _obj = ModleTimeTable();
    Dbhelper dbhelper = Dbhelper.intance;

    print(await dbhelper.checkStatus(DateTime.now()));

    if (await dbhelper.checkStatus(DateTime.now()) == true) {
      _obj = await dbhelper.getMealName(DateTime.now());

      ModleHistory _modleTimeTable = ModleHistory();
      _modleTimeTable.day = DateTime.now().toString();
      _modleTimeTable.lunch = 1;
      _modleTimeTable.dinner = 0;
      _modleTimeTable.lunchRs = (quantity * 0);
      _modleTimeTable.dinnerRs = 0;
      var id = await dbhelper.insertmeal(_modleTimeTable);
      print(id);
    } else {
      _obj = await dbhelper.getMealName(DateTime.now());

      ModleHistory _modleTimeTable = ModleHistory();
      _modleTimeTable.day = DateTime.now().toString();
      _modleTimeTable.lunch = 1;
      _modleTimeTable.lunchRs = (quantity * 0);
      var id = await dbhelper.updateLunch(_modleTimeTable);
    }
  }
  void insertDinner() async {
    ModleTimeTable _obj = ModleTimeTable();
    Dbhelper dbhelper = Dbhelper.intance;
    print(await dbhelper.checkStatus(DateTime.now()));

    if (await dbhelper.checkStatus(DateTime.now()) == true) {
      _obj = await dbhelper.getMealName(DateTime.now());

      ModleHistory _modleTimeTable = ModleHistory();
      _modleTimeTable.day = DateTime.now().toString();
      _modleTimeTable.lunch = 0;
      _modleTimeTable.dinner = 1;
      _modleTimeTable.lunchRs = 0;
      _modleTimeTable.dinnerRs =
          (quantity * int.parse(_obj.dinnerRs.toString()));
      var id = await dbhelper.insertmeal(_modleTimeTable);
      print(id);
    } else {
      print("jhcjhxc");
      _obj = await dbhelper.getMealName(DateTime.now());

      ModleHistory _modleTimeTable = ModleHistory();
      _modleTimeTable.dinner = 1;
      _modleTimeTable.dinnerRs =
          (quantity * int.parse(_obj.dinnerRs.toString()));
      var id = await dbhelper.updateDinner(_modleTimeTable);
    }
  }

  void insertDinnerNo() async {
    ModleTimeTable _obj = ModleTimeTable();
    Dbhelper dbhelper = Dbhelper.intance;
    print(await dbhelper.checkStatus(DateTime.now()));

    if (await dbhelper.checkStatus(DateTime.now()) == true) {
      _obj = await dbhelper.getMealName(DateTime.now());

      ModleHistory _modleTimeTable = ModleHistory();
      _modleTimeTable.day = DateTime.now().toString();
      _modleTimeTable.lunch = 0;
      _modleTimeTable.dinner = 1;
      _modleTimeTable.lunchRs = 0;
      _modleTimeTable.dinnerRs =
      (quantity * 0);
      var id = await dbhelper.insertmeal(_modleTimeTable);
      print(id);
    } else {
      print("jhcjhxc");
      _obj = await dbhelper.getMealName(DateTime.now());

      ModleHistory _modleTimeTable = ModleHistory();
      _modleTimeTable.dinner = 1;
      _modleTimeTable.dinnerRs =
      (quantity * 0);
      var id = await dbhelper.updateDinner(_modleTimeTable);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 110,
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Theme.of(context).primaryColor,
              isDismissible: false,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              context: context,
              builder: (context) => buildSheet());
        },
        child: Text("+ Add Meal"),
        style: ElevatedButton.styleFrom(
            primary: kBlueColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  Widget buildSheet() {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            'Add Meal',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Counter(),
        SizedBox(
          height: 20,
        ),
        Text(
          'Do you want to add Lunch',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        isLunch == null || isLunch == 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      insertLunchNo();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Confirmation()));
                    },
                    child: Container(
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Center(
                          child: Text(
                        "No",
                        style:
                            TextStyle(color: Theme.of(context).iconTheme.color),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 40,
                    width: 110,
                    child: ElevatedButton(
                      onPressed: () {
                        insertLunch();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Confirmation()));
                      },
                      child: Text(
                        "Yes",
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: kBlueColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ],
              )
            : Text(
                'Added',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Do you want to add Dinner',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        isDinner == null || isDinner == 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      insertDinnerNo();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Confirmation()));
                    },
                    child: Container(
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Center(
                          child: Text(
                        "No",
                        style:
                            TextStyle(color: Theme.of(context).iconTheme.color),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 40,
                    width: 110,
                    child: ElevatedButton(
                      onPressed: () {
                        insertDinner();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Confirmation()));
                      },
                      child: Text(
                        "Yes",
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: kBlueColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ],
              )
            : Text(
                'Added',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            SizedBox(height: 40,)
      ]),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: kBlueColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  if (quantity > 1) {
                    setState(() {
                      quantity--;
                    });
                  }
                },
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 28,
                )),
            Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.symmetric(horizontal: 3),
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3), color: Colors.white),
              child: Center(
                child: Text(
                  quantity.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    quantity++;
                  });
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 28,
                )),
          ],
        ),
      ),
    );
  }
}

class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => Bottom(
                      current: 0,
                    )),
            (route) => false));
  }

  Future<bool> _willPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/confirmation.gif",
                  height: 250,
                  width: 200,
                ),
                Text(
                  "Added Successfully",
                  style: GoogleFonts.mcLaren(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
