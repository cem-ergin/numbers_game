import 'package:flutter/material.dart';

class GuessPage extends StatefulWidget {
  GuessPage({Key key}) : super(key: key);

  @override
  GuessPageState createState() => GuessPageState();
}

class GuessPageState extends State<GuessPage> {
  String _number = "";
  @override
  void initState() {
    super.initState();
    _number = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Center(
              child: Text(
                "$_number",
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 12,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: myGridViewWidgets(index),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget myGridViewWidgets(int index) {
    if (index == 9) {
      return _number.length > 0
          ? Center(
              child: IconButton(
                icon: Icon(Icons.backspace),
                onPressed: () {
                  _number = _number.substring(0, _number.length - 1);
                  setState(() {});
                },
              ),
            )
          : Center(
              child: IconButton(
                icon: Icon(Icons.backspace, color: Colors.grey),
                onPressed: null,
              ),
            );
    }
    if (index == 10) {
      return _number.contains("0") || _number.length < 1 || _number.length == 4
          ? Container(
              color: Colors.grey,
              child: Center(
                child: Text("0"),
              ),
            )
          : InkWell(
              onTap: () {
                _number = "${_number}0";
                setState(() {});
              },
              child: Center(
                child: Text("0"),
              ),
            );
    }
    if (index == 11) {
      return Center(
        child: _number.length == 4
            ? IconButton(
                icon: Icon(Icons.check_circle),
                onPressed: () {},
              )
            : IconButton(
                icon: Icon(Icons.check_circle, color: Colors.grey),
                onPressed: null,
              ),
      );
    }
    return !_number.contains("${index + 1}") && _number.length <= 3
        ? InkWell(
            onTap: () {
              _number = "$_number${index + 1}";
              setState(() {});
            },
            child: Center(
              child: Text("${index + 1}"),
            ),
          )
        : Container(
            color: Colors.grey,
            child: Center(
              child: Text("${index + 1}"),
            ),
          );
  }
}
