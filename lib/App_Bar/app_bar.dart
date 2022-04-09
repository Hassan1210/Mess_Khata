import 'package:flutter/material.dart';
import 'mytheme.dart';
import 'package:provider/provider.dart';
// ignore_for_file: prefer_const_constructors

class App_Bar extends StatelessWidget {
  const App_Bar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Material(
      elevation: 2,
      child: Container(
        height: 56,
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Home",
                  style: TextStyle(
                      color: Theme.of(context).iconTheme.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              GestureDetector(
                onTap: () {
                  final provider = Provider.of<ThemeProvider>(context,listen: false);
                  provider.update(themeProvider.isLight?true:false);

                },
                child: Icon(
                  themeProvider.isLight
                      ? Icons.wb_sunny
                      : Icons.nightlight_round,
                  color: themeProvider.isLight ? Colors.white : Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
