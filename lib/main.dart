

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Sample'),
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
  List<Question> _items = [
    Question(
      id: 1,
      title: 'whats your name?',
      upclick:false,
      downclick:false
    ),
    Question(
      id: 2,
      title: 'which food you like most?',
            upclick:false,
      downclick:false
    ),
    Question(
      id: 3,
      title: 'Where you want to go?',
            upclick:false,
      downclick:false
    ),
    Question(
      id: 4,
      title: 'Where you want to sdsd?',
            upclick:false,
      downclick:false
    ),
    Question(
      id: 5,
      title: 'Where you want to go?',
      upclick:true,
      downclick:false
    ),
  ];

  void pressedyes(data) {
    if (this.noarray.contains(data.toString())) {
      this.noarray.remove(data.toString());
      this.yesarray.add(data.toString());
      this.yesarray.toSet();
    } else {
      this.yesarray.add(data.toString());
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
      this.noarray.toSet();
    } else {
      this.noarray.add(data.toString());
      this.noarray.toSet();
    }
    print('yesarray:  + ${this.yesarray.toSet()}');
    print('noarray:  + ${this.noarray.toSet()}');
  }

  //Todo ENABLE SUBMIT BUTTON BASED ON CONDITION ALL FILLED 
  void submit(){


      if(this.yesarray.length == 5){
        print('object');
        _showMyDialog(yesarray.toSet().length.toString());
      }else{
         _showMyDialog(yesarray.toSet().length.toString());
        print('sdfsd');
      }
      //Todo empty arrays and object and refresh 
  }

  Future<void> _showMyDialog(response) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('You are In'),
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
          title: Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
            width: 120.0,
          ),
        ),
        body: Container(
          color: const Color(0x111B5800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Expanded(
                    child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    primary: true,
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    '${_items[index].title}',
                                    style: TextStyle(fontSize: 20.0),
                                  )),
                              Container(
                                child: ButtonBar(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.thumb_up,
                                      ),
                                      iconSize: 30,
                                      //color: 'pressAttention-${_items[index].id.toString()}' ? Colors.grey : Colors.blue,
                                      color: Colors.grey,
                                      onPressed: () {
                                        pressedyes(_items[index].id);
                                        setState(() {
                                          
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.thumb_down,
                                      ),
                                      iconSize: 30,
                                      color: Colors.grey,
                                      onPressed: () {
                                        pressedno(_items[index].id);
                                      },
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
              FlatButton(
              color: Colors.blue,
                onPressed: (){
                      submit();
                },
                child: Text('Submit',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white
              ),
              
              ),
              )
            ],
          ),
        ));
  }
}

class Question {
  final int id;
  final String title;
  final bool upclick;
  final bool downclick;

  Question({
    @required this.id,
    @required this.title,
    @required this.upclick,
    @required this.downclick,
  });
}
