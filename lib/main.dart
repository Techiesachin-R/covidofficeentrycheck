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
  var arr = new List(5);
  var arrno = new List(5);

List<Question> _items = [
    Question(
      idy: 'y1',
      idn: 'n1',
      title: 'whats your name?',
    ),
    Question(
      idy: 'y2',
      idn: 'n2',
      title: 'which food you like most?',
    ),
    Question(
      idy: 'y3',
      idn: 'n3',
      title: 'Where you want to go?',
    ),
    Question(
      idy: 'y4',
      idn: 'n4',
      title: 'Where you want to go?',
    ),
    Question(
      idy: 'y5',
      idn: 'n5',
      title: 'Where you want to go?',
    ),
  ];


  int _yes = 0;
  int _no= 0;
  bool pressAttention = true;


  void _incrementyesCounter() {
    setState(() {
      _yes ++;
      this.pressAttention = false;
      this.arr.add('yes');
    });
  }

  void _incrementnoCounter() {
    setState(() {
      _no ++;
    });
  }

  void pressedyes(data){
      this.arr.add(data);
      print(this.arr);
  }

  void pressedno(data){
      this.arr.add(data);
      print(this.arr);
  }

  @override

  Widget _qiestioncard(){
    return  Card(
              child: Container(
                color: const Color(0x2e3d9800),
                child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text('What your task today ?',
                      style: TextStyle(
                        fontSize: 20.0
                      ),)),
                    Container(
                      child: ButtonBar(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.thumb_up,
                            ),
                            iconSize: 30,
                            color: pressAttention ? Colors.grey : Colors.blue,
                            onPressed: _incrementyesCounter,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.thumb_down,
                            ),
                            iconSize: 30,
                            color:Colors.grey,
                            onPressed: _incrementnoCounter,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png', fit: BoxFit.cover,
        width: 120.0,),
      ),
      body: Container(
        color: const Color(0x111B5800),
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
          return  Card(
              child: Container(
                child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15.0),
                      child: Text('${_items[index].title}',
                      style: TextStyle(
                        fontSize: 20.0
                      ),)),
                    Container(
                      child: ButtonBar(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.thumb_up,
                            ),
                            iconSize: 30,
                            color: pressAttention ? Colors.grey : Colors.blue,
                            onPressed: (){
                              pressedyes(_items[index].idy);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.thumb_down,
                            ),
                            iconSize: 30,
                            color:Colors.grey,
                            onPressed: _incrementnoCounter,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          
          // ListTile(
          //   title: Text('${_items[index].title}'),
          // );
          }
        )
      ));
  }
}


class Question {
  final String idy;
  final String idn;
  final String title;


  Question({
    @required this.idy,
    @required this.idn,
    @required this.title,
  });
}