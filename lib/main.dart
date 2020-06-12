import 'dart:collection';

import 'package:covidselfassessment/failure.dart';
import 'package:covidselfassessment/success.dart';
import 'package:flutter/material.dart';

import 'failure.dart';
import 'success.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primaryColor: const Color(0xFF2E3D98),
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(title: 'Covid Self Declaration'),
      routes: {
        "/success": (_) => new Success(),
        "/failed": (_) => new Failure(),
      },
      // home: Failure()
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Set yesarray = new HashSet<String>();
  Set noarray = new HashSet<String>();
  bool isAllItemsFilled = false;

  List<Question> _items = [
    Question(
        id: 1,
        title: 'I do not have flu like symptoms',
        upclick: false,
        downclick: false),
    Question(
        id: 2,
        title: 'I do not have a temparature',
        upclick: false,
        downclick: false),
    Question(
        id: 3,
        title: 'I have not been exposed to COVID-19',
        upclick: false,
        downclick: false),
    Question(
        id: 4,
        title: 'I believe I am not sick and can enter the office',
        upclick: false,
        downclick: false),
  ];

  void pressedyes(data) {
    if (this.noarray.contains(data.toString())) {
      this.noarray.remove(data.toString());
    }
    setState(() {
      if (_items[data - 1].downclick) {
        _items[data - 1].downclick = false;
      }

      if (!_items[data - 1].upclick) {
        this.yesarray.add(data.toString());
      } else {
        this.yesarray.remove(data.toString());
      }

      _items[data - 1].upclick = !_items[data - 1].upclick;
      if ((this.yesarray.length + this.noarray.length) == _items.length) {
        isAllItemsFilled = true;
      } else {
        isAllItemsFilled = false;
      }
    });
    // this.yesarray.toSet();

    debugPrint('yesarray:  + ${this.yesarray}');
    debugPrint('noarray:  + ${this.noarray}');
  }

  void pressedno(data) {
    if (this.yesarray.contains(data.toString())) {
      this.yesarray.remove(data.toString());
    }
    setState(() {
      if (_items[data - 1].upclick) {
        _items[data - 1].upclick = false;
      }

      if (!_items[data - 1].downclick) {
        this.noarray.add(data.toString());
      } else {
        this.noarray.remove(data.toString());
      }

      _items[data - 1].downclick = !_items[data - 1].downclick;
      if ((this.yesarray.length + this.noarray.length) == _items.length) {
        isAllItemsFilled = true;
      } else {
        isAllItemsFilled = false;
      }
    });

    debugPrint('yesarray:  + ${this.yesarray}');
    debugPrint('noarray:  + ${this.noarray}');
  }

  void submit() {
    if (this.yesarray.length + this.noarray.length < _items.length) {
      debugPrint('Fill all the declaration items');
    } else {
      if (this.yesarray.length == _items.length) {
        Navigator.pushReplacementNamed(context, "/success");
      } else {
        Navigator.pushReplacementNamed(context, "/failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Image(
            image: AssetImage('assets/appbar_bg.png'),
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/logo_white.png',
                fit: BoxFit.scaleDown,
                width: 135.0,
                height: 50.0,
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
          color: const Color(0x111B5800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Self-declaration",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              new Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    primary: true,
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Color(0xFFF3F6FB),
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.fromLTRB(
                                      15.0, 10.0, 10.0, 0.0),
                                  child: Text(
                                    '${_items[index].title}',
                                    style: TextStyle(fontSize: 15.0),
                                  )),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ButtonBar(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(
                                            Icons.thumb_up,
                                          ),
                                          iconSize: 18,
                                          color: _items[index].upclick
                                              ? Color(0xFF2E3D98)
                                              : Colors.grey,
                                          onPressed: () {
                                            pressedyes(_items[index].id);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.thumb_down,
                                          ),
                                          iconSize: 18,
                                          color: _items[index].downclick
                                              ? Color(0xFFDF3324)
                                              : Colors.grey,
                                          onPressed: () {
                                            pressedno(_items[index].id);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                width: 110,
                height: 40,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 10,
                  color:
                      isAllItemsFilled ? Color(0xFF2E3D98) : Color(0xFF999999),
                  onPressed: () {
                    isAllItemsFilled ? submit() : null;
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        letterSpacing: 1.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ));
  }
}

class Question {
  final int id;
  final String title;
  bool upclick;
  bool downclick;

  Question({
    @required this.id,
    @required this.title,
    @required this.upclick,
    @required this.downclick,
  });
}
