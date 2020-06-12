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
      home: MyHomePage(),
      routes: {
        "/success": (_) => new Success(),
        "/failed": (_) => new Failure(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List of questions
  List<String> questions = [
    'I do not have flu like symptoms',
    'I do not have a temparature',
    'I have not been exposed to COVID-19',
    'I believe I am not sick and can enter the office'
  ];
  List<Question> _items = new List<Question>();

  Set yesarray = new HashSet<int>();
  Set noarray = new HashSet<int>();
  bool isAllItemsFilled = false;

  // Static images
  static Image likeIconUnselected = Image.asset('assets/like.png');
  static Image likeIconSelected = Image.asset('assets/like_selected.png');
  static Image dislikeIconUnselected = Image.asset('assets/dislike.png');
  static Image dislikeIconSelected = Image.asset('assets/dislike_selected.png');

  AssetImage appbarBG = AssetImage('assets/appbar_bg.png');
  Image appbarLogo = Image.asset(
    'assets/logo_white.png',
    fit: BoxFit.scaleDown,
    width: 130.0,
    height: 50.0,
  );

  // Default image assignment
  Image likeIcon = likeIconUnselected;
  Image dislikeIcon = dislikeIconUnselected;


  @override
  void initState() {
    super.initState();
    // Additional initialization of the State
    for (int i = 0; i < questions.length; i++) {
      _items.add(new Question(i, questions[i]));
    }
  }

  /*
    upVote - up vote function
    index - The index of the question
  */
  void upVote(index) {
    setState(() {
      if (this.noarray.contains(index)) {
        this.noarray.remove(index);
        _items[index].dislikeIcon = dislikeIconUnselected;
      }

      if (_items[index].downclick) {
        _items[index].downclick = false;
      }

      if (!_items[index].upclick) {
        this.yesarray.add(index);
        _items[index].likeIcon = likeIconSelected;
      } else {
        this.yesarray.remove(index);
        _items[index].likeIcon = likeIconUnselected;
      }

      _items[index].upclick = !_items[index].upclick;

      if ((this.yesarray.length + this.noarray.length) == _items.length) {
        isAllItemsFilled = true;
      } else {
        isAllItemsFilled = false;
      }
    });

    debugPrint('yesarray:  + ${this.yesarray}');
    debugPrint('noarray:  + ${this.noarray}');
  }

  /*
    downVote - down vote function
    index - The index of the question
   */
  void downVote(index) {
    setState(() {
      if (this.yesarray.contains(index)) {
        this.yesarray.remove(index);
        _items[index].likeIcon = likeIconUnselected;
      }

      if (_items[index].upclick) {
        _items[index].upclick = false;
      }

      if (!_items[index].downclick) {
        this.noarray.add(index);
        _items[index].dislikeIcon = dislikeIconSelected;
      } else {
        this.noarray.remove(index);
        _items[index].dislikeIcon = dislikeIconUnselected;
      }

      _items[index].downclick = !_items[index].downclick;

      if ((this.yesarray.length + this.noarray.length) == _items.length) {
        isAllItemsFilled = true;
      } else {
        isAllItemsFilled = false;
      }
    });

    debugPrint('yesarray:  + ${this.yesarray}');
    debugPrint('noarray:  + ${this.noarray}');
  }

  /*
    submit function
   */
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
    // Strings
    final String appTitle = "Self-declaration";
    final String submitText = "Submit";

    // Colors
    final Color cardBGcolor = Color(0xFFF3F6FB);
    final Color bodyBGcolor = Color(0xFFFFFFFF);
    final Color submitTextColor = Color(0xFFFFFFFF);
    final Color submitDisabledBGcolor = Color(0xFF999999);
    final Color submitEnabledBGcolor = Color(0xFF2E3D98);

    // Font Size
    final double submitTextFontSize = 16.0;
    final double likeDislikeIconSize = 18.0;

    // TextStyles
    final TextStyle questionTextStyle = TextStyle(fontSize: 15.0);
    final TextStyle submitTextStyle = TextStyle(
        fontSize: submitTextFontSize,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: submitTextColor,
        letterSpacing: 1.0);

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Image(
            image: appbarBG,
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[appbarLogo],
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0),
          color: bodyBGcolor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  appTitle,
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
                      IconButton likeIconButton = IconButton(
                        icon: (_items[index].likeIcon),
                        iconSize: likeDislikeIconSize,
                        onPressed: () {
                          upVote(_items[index].id);
                        },
                      );

                      IconButton dislikeIconButton = IconButton(
                        icon: (_items[index].dislikeIcon),
                        iconSize: likeDislikeIconSize,
                        onPressed: () {
                          downVote(_items[index].id);
                        },
                      );

                      return Card(
                        color: cardBGcolor,
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
                                    style: questionTextStyle,
                                  )),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ButtonBar(
                                      children: <Widget>[
                                        likeIconButton,
                                        dislikeIconButton,
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
                  color: isAllItemsFilled
                      ? submitEnabledBGcolor
                      : submitDisabledBGcolor,
                  onPressed: () {
                    if (isAllItemsFilled) {
                      submit();
                    }
                  },
                  child: Text(
                    submitText,
                    style: submitTextStyle,
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

  @override
 void dispose(){
  // Additional disposal code
  _items.clear();
  super.dispose();
 }
}

// Question class
class Question {
  int id;
  String title;
  bool upclick;
  bool downclick;
  Image likeIcon;
  Image dislikeIcon;

  // Question Constuctor with two arguments
  Question(int id, String title) {
    this.id = id;
    this.title = title;
    this.upclick = false;
    this.downclick = false;
    this.likeIcon = Image.asset('assets/like.png');
    this.dislikeIcon = Image.asset('assets/dislike.png');
  }
}
