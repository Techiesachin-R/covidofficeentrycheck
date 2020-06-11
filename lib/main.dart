import 'package:covidselfassessment/failure.dart';
import 'package:covidselfassessment/success.dart';
import 'package:flutter/material.dart';

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
        home: MyHomePage(title: 'OT Covid Self Assessment'),
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
  List yesarray = <String>[];
  List noarray = <String>[];
  bool pressAttention = false;
  bool hityes = false;
  List<Question> _items = [
    Question(id: 1, title: 'I am not sick', upclick: false, downclick: false),
    Question(
        id: 2,
        title: 'I do not have flu like symptoms',
        upclick: false,
        downclick: false),
    Question(
        id: 3,
        title: 'I have not been exposed to COVID-19',
        upclick: false,
        downclick: false),
    Question(
        id: 4,
        title: 'I do not have high temparature',
        upclick: false,
        downclick: false),
    Question(
        id: 5, title: 'I have a face mask', upclick: false, downclick: false),
  ];

  void pressedyes(data) {
    if (this.noarray.contains(data.toString())) {
      this.noarray.remove(data.toString());
      this.yesarray.add(data.toString());
      setState(() {
        if (_items[data - 1].downclick) {
          _items[data - 1].downclick = false;
        }
        _items[data - 1].upclick = !_items[data - 1].upclick;
      });
      this.yesarray.toSet();
    } else {
      this.yesarray.add(data.toString());
      setState(() {
        if (_items[data - 1].downclick) {
          _items[data - 1].downclick = false;
        }
        _items[data - 1].upclick = !_items[data - 1].upclick;
      });
      this.yesarray.toSet();
    }
    print('yesarray:  + ${this.yesarray.toSet()}');
    print('noarray:  + ${this.noarray.toSet()}');
    print('id : ${_items[data].upclick}');
  }

  void pressedno(data) {
    if (this.yesarray.contains(data.toString())) {
      this.yesarray.remove(data.toString());
      this.noarray.add(data.toString());
      setState(() {
        if (_items[data - 1].upclick) {
          _items[data - 1].upclick = false;
        }
        _items[data - 1].downclick = !_items[data - 1].downclick;
      });
      this.noarray.toSet();
    } else {
      this.noarray.add(data.toString());
      setState(() {
        if (_items[data - 1].upclick) {
          _items[data - 1].upclick = false;
        }
        _items[data - 1].downclick = !_items[data - 1].downclick;
      });
      this.noarray.toSet();
    }
    print('yesarray:  + ${this.yesarray.toSet()}');
    print('noarray:  + ${this.noarray.toSet()}');
  }

  //Todo ENABLE SUBMIT BUTTON BASED ON CONDITION ALL FILLED

  void submit() {
    if (this.yesarray.toSet().length == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Success()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Failure()),
      );
    }
    //Todo empty arrays and object and refresh
  }

  Future<void> _showMyDialog(response) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Entry Status'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(response),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
                width: 120.0,
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
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                                  padding:
                                      EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                                  child: Text(
                                    '${_items[index].title}',
                                    style: TextStyle(fontSize: 18.0),
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
                                          iconSize: 20,
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
                                          iconSize: 20,
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
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.blue)),
                elevation: 10,
                color: Color(0xFF2E3D98),
                onPressed: () {
                  submit();
                },
                child: Text(
                  'SUBMIT',
                  style: TextStyle(
                      fontSize: 20.0, color: Colors.white, letterSpacing: 2.0),
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
