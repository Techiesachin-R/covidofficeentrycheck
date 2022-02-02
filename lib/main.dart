import 'dart:collection';

import 'package:covidselfassessment/failure.dart';
import 'package:covidselfassessment/success.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

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
    'I <b>do not</b> have flu like symptoms',
    'I <b>do not</b> have a temperature',
    'I <b>have not</b> been exposed to COVID-19',
    'I believe I am <b>not</b> sick and can enter the office'
  ];
  List<Question> _items = <Question>[];

  Set yesarray = new HashSet<int>();
  Set noarray = new HashSet<int>();
  bool isAllItemsFilled = false;

  Color unselectedYesBGColor = Color(0xFFECF1FA);
  Color selectedYesBGColor = Color(0xFF2E3D98);
  Color unselectedNoBGColor = Color(0xFFFCEBEA);
  Color selectedNoBGColor = Color(0xFFDF3324);

  Color unselectedYesBtnColor = Color(0xFF2E3D98);
  Color unselectedNoBtnColor = Color(0xFFDF3324);
  Color selectedBtnColor = Color(0xFFFFFFFF);

  AssetImage appbarBG = AssetImage('assets/appbar_bg.png');
  Image appbarLogo = Image.asset(
    'assets/logo_white.png',
    fit: BoxFit.scaleDown,
    width: 130.0,
    height: 50.0,
  );

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
      }

      if (_items[index].downclick) {
        _items[index].downclick = false;
      }

      if (!_items[index].upclick) {
        this.yesarray.add(index);
      } else {
        this.yesarray.remove(index);
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
      }

      if (_items[index].upclick) {
        _items[index].upclick = false;
      }

      if (!_items[index].downclick) {
        this.noarray.add(index);
      } else {
        this.noarray.remove(index);
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
    final String declarationHeading = "Self Declaration";
    final String submitText = "Submit";

    // Colors
    final Color cardBGcolor = Color(0xFFFFFFFF);
    final Color bodyBGcolor = Color(0xFFF3F6FB);
    final Color submitTextColor = Color(0xFFFFFFFF);
    final Color submitDisabledBGcolor = Color(0xFF999999);
    final Color submitEnabledBGcolor = Color(0xFF2E3D98);

    // Font Size
    final double submitTextFontSize = 16.0;

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Declaration Heading
              Container(
                margin: EdgeInsets.all(15.0),
                child: Text(
                  declarationHeading,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              // Question List
              Container(
                child: Flexible(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      primary: true,
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        ElevatedButton yesBtn = ElevatedButton(
                          onPressed: () {
                            upVote(_items[index].id);
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              )),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  _items[index].upclick
                                      ? selectedYesBGColor
                                      : unselectedYesBGColor)),
                          child: Text(
                            'Yes',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: _items[index].upclick
                                    ? selectedBtnColor
                                    : unselectedYesBtnColor),
                          ),
                        );
                        ElevatedButton noBtn = ElevatedButton(
                          onPressed: () {
                            downVote(_items[index].id);
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              )),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  _items[index].downclick
                                      ? selectedNoBGColor
                                      : unselectedNoBGColor)),
                          child: Text(
                            'No',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: _items[index].downclick
                                    ? selectedBtnColor
                                    : unselectedNoBtnColor),
                          ),
                        );

                        return Card(
                          color: cardBGcolor,
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.fromLTRB(
                                        10.0, 10.0, 10.0, 0.0),
                                    child: RichText(
                                      text: HTML.toTextSpan(
                                          context, '${_items[index].title}',
                                          defaultTextStyle: questionTextStyle),
                                    )),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ButtonBar(
                                        buttonPadding: EdgeInsets.all(5.0),
                                        children: <Widget>[
                                          Container(
                                            width: 70,
                                            height: 32,
                                            margin: EdgeInsets.all(12.0),
                                            child: yesBtn,
                                          ),
                                          Container(
                                            width: 70,
                                            height: 32,
                                            margin: EdgeInsets.all(12.0),
                                            child: noBtn,
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
              ),
              // Submit button
              Container(
                width: 110,
                height: 40,
                margin: EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          isAllItemsFilled
                              ? submitEnabledBGcolor
                              : submitDisabledBGcolor)),
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
            ],
          ),
        ));
  }

  @override
  void dispose() {
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

  // Question Constructor with two arguments
  Question(int id, String title) {
    this.id = id;
    this.title = title;
    this.upclick = false;
    this.downclick = false;
  }
}
