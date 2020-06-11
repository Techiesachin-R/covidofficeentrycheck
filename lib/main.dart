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
      id: 'y1',
      title: 'whats your name?',
    ),
    Question(
      id: 'y2',
      title: 'which food you like most?',
    ),
    Question(
      id: 'y3',
      title: 'Where you want to go?',
    ),
    Question(
      id: 'y4',
      title: 'Where you want to sdsd?',
    ),
    Question(
      id: 'y5',
      title: 'Where you want to go?',
    ),
  ];




  // void _incrementyesCounter() {
  //   setState(() {
  //     _yes ++;
  //     this.pressAttention = false;
  //     this.arr.add('yes');
  //   });
  // }

  // void _incrementnoCounter() {
  //   setState(() {
  //     _no ++;
  //   });
  // }

  void pressedyes(data){
      this.arr.add(data);
      print(this.arr);
  }

  void pressedno(data){
      this.arr.add(data);
      print(this.arr);
  }

  @override
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
                            color: Colors.grey,
                            onPressed: (){
                              pressedyes(_items[index].id);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.thumb_down,
                            ),
                            iconSize: 30,
                            color:Colors.grey,
                            onPressed: (){
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
          
          // ListTile(
          //   title: Text('${_items[index].title}'),
          // );
          }
        )
      ));
  }
}


class Question {
  final String id;
  final String title;


  Question({
    @required this.id,
    @required this.title,
  });
}