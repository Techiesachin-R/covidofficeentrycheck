import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class Success extends StatelessWidget {
  const Success({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('opentext', style: TextStyle(fontSize: 30.0),),backgroundColor: Colors.white, elevation: 0.0, centerTitle: true),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
                  [dd, 'th ', M, ' ', yyyy, ' ', hh, ':', nn, ' ', am]),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18.0, color: Color(0xFF757575), letterSpacing: 1.5),
            ),
            SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/success.png',
              width: 250.0,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'You may enter the office.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFF338275),
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        )),
      ),
    );
  }
}
