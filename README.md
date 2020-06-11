# sample

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



Card(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'What your task today ?',
                          style: TextStyle(fontSize: 20.0),
                        )),
                    Container(
                        child: ToggleButtons(
                      children: <Widget>[
                        Icon(Icons.thumb_up),
                        Icon(Icons.thumb_down),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < isSelected.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected[buttonIndex] = true;
                            } else {
                              isSelected[buttonIndex] = false;
                            }
                          }
                        });
                      },
                      isSelected: isSelected,
                    )),
                  ],
                ),
              ),
            );




            
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            _qiestioncard(),
            _qiestioncard(),
            _qiestioncard(),
            _qiestioncard(),
            _qiestioncard(),
            Divider(
              height: 5.0,
            ),

            Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text(
              'You have selected Yes: ${this.arr.length} times',
            ),
            Text(
              'You have selected No: $_no times',
            ),
            ]
            ),

            Divider(
              height: 5.0,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: FlatButton(
                color: Colors.blue,
                child: const Text('Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
                ),),
                onPressed: () {/* ... */},
              ),
            ),
           
          ],
        ),
      ),

    );
  }
}