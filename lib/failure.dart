import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class Failure extends StatelessWidget {
  const Failure({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo_black.png',
              fit: BoxFit.scaleDown,
              width: 130.0,
              height: 50.0,
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
                  fontSize: 16.0, color: Color(0xFF757575), letterSpacing: 1.2),
            ),
            SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/noentry_ill.png',
              width: 240.0,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(
              height: 30,
            ),
            Wrap(direction: Axis.vertical, //Vertical || Horizontal
                children: <Widget>[
                  Text(
                    'Do not Enter',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28.0,
                        color: Color(0xFFDF3324),
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  )
                ]),
          ],
        )),
      ),
    );
  }
}
