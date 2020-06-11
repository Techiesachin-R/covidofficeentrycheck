import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class Failure extends StatelessWidget {
  const Failure({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              width: 120.0,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              formatDate(DateTime.now(),
                  [dd, '-', MM, '-', yyyy, ' ', hh, ':', nn, ':', ss, ' ', am]),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0, color: Colors.green, letterSpacing: 2.0),
            ),
            SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/failure.png',
              width: 250.0,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Please get well soon\nand then return to office.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0, color: Color(0xFFDF3324), letterSpacing: 2.0),
            )
          ],
        )),
      ),
    );
  }
}
