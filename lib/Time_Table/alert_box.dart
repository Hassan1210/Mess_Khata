import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors
import 'package:mess_khata/constant.dart';
import 'package:mess_khata/Time_Table/time_modle.dart';
import 'package:mess_khata/DB Helper/db_helper.dart';
import 'package:mess_khata/App_Bar/botom_bar.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

class MyDialog extends StatefulWidget {
  MyDialog(
      {required this.id,
      required this.lunchName,
      required this.lunchRs,
      required this.dinnerRs,
      required this.dinnerName,
      required this.day
      });
  final int id;
  final String dinnerName;
  final String dinnerRs;
  final String lunchName;
  final String lunchRs;
  final String day;

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lunchName = lunchNameController.text = widget.lunchName.toString();
    lunchRs = lunchRsController.text = widget.lunchRs.toString();
    dinnerName = dinnerNameController.text = widget.dinnerName.toString();
    dinnerRs = dinnerRsController.text = widget.dinnerRs.toString();
  }

  int? id;
  String? dinnerName;
  String? dinnerRs;
  String? lunchName;
  String? lunchRs;

  bool isEdit = false;

  var lunchNameController = TextEditingController();
  var lunchRsController = TextEditingController();
  var dinnerNameController = TextEditingController();
  var dinnerRsController = TextEditingController();

  bool IsEmpty() {
    if (lunchNameController.text.isNotEmpty &&
        lunchRsController.text.isNotEmpty &&
        dinnerNameController.text.isNotEmpty &&
        dinnerRsController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)), //this right here
        child: Container(
            height: 360,
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Column(children: [
              SizedBox(
                height: 25,
              ),
              Text(
                "${widget.day} schedule",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Theme.of(context).iconTheme.color),
              ),
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
                          "Lunch",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 14, right: 14),
                        height: 52,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              controller: lunchNameController,
                              autofocus: false,
                              cursorColor: Theme.of(context).iconTheme.color,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              decoration: InputDecoration(
                                hintText: "Enter Lunch Name",
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).dividerColor,
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
                              onChanged: (value) {
                                setState(() {
                                  lunchName = value.toString();
                                  isEdit = true;
                                });
                              },
                            ))
                          ],
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
                          "Lunch Rs.",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 14, right: 14),
                        height: 52,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                                    controller: lunchRsController,
                                    keyboardType: TextInputType.number,
                                    autofocus: false,
                                    cursorColor:
                                        Theme.of(context).iconTheme.color,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Enter Lunch Rs.",
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).dividerColor,
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
                                    onChanged: (value) {
                                      setState(() {
                                        isEdit = true;
                                        lunchRs = value.toString();
                                      });
                                    }))
                          ],
                        ),
                      )
                    ],
                  )),
                ],
              ),
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
                          "Dinner",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 14, right: 14),
                        height: 52,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  isEdit = true;
                                  dinnerName = value.toString();
                                });
                              },
                              controller: dinnerNameController,
                              autofocus: false,
                              cursorColor: Theme.of(context).iconTheme.color,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              decoration: InputDecoration(
                                hintText: "Enter Dinner Name",
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).dividerColor,
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
                          "Dinner Rs.",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(left: 14, right: 14),
                        height: 52,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  dinnerRs = value.toString();
                                  isEdit = true;
                                });
                              },
                              controller: dinnerRsController,
                              keyboardType: TextInputType.number,
                              autofocus: false,
                              cursorColor: Theme.of(context).iconTheme.color,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              decoration: InputDecoration(
                                hintText: "Enter Dinner Rs.",
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).dividerColor,
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
                      )
                    ],
                  )),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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
                        "Cancel",
                        style:
                            TextStyle(color: Theme.of(context).iconTheme.color),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 110,
                    child: ElevatedButton(
                      onPressed: IsEmpty() && isEdit
                          ? () async {
                              ModleTimeTable _modleTimeTable = ModleTimeTable();
                              _modleTimeTable.id = widget.id;
                              _modleTimeTable.lunch = lunchName.toString();
                              _modleTimeTable.lunchRs =
                                  int.parse(lunchRs.toString());
                              print(_modleTimeTable.lunchRs);
                              _modleTimeTable.dinner = dinnerName.toString();
                              _modleTimeTable.dinnerRs =
                                  int.parse(dinnerRs.toString());
                              Dbhelper dbhelper = Dbhelper.intance;
                              try {
                                await dbhelper.updateTimeTable(_modleTimeTable);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Confirmation()));
                              } catch (e) {}
                            }
                          : null,
                      child: Text("Update"),
                      style: ElevatedButton.styleFrom(
                          primary: kBlueColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              )
            ])),
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
        const Duration(seconds:3),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => Bottom(
                      current: 1,
                    )),
            (route) => false));
  }
 Future<bool>_willPop()async{
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
          body:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/confirmation.gif",height: 250,width: 200,),
                Text("Updated Successfully",
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
