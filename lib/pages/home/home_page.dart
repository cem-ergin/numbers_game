import 'package:flutter/material.dart';
import 'package:sayiciklar/helper/bloc_helper.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                BlocHelper.logout(context: context);
              },
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Sayıyı arkadaşın yazsın",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("ya da"),
                ),
                Expanded(
                  child: Divider(color: Colors.black),
                ),
              ],
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/playWithComputerPage");
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Bilgisayara karşı oyna",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _calculate(GuessProvider _guessProvider) {
  //   _arti = 0;
  //   _eksi = 0;
  //   for (var i = 0; i < 4; i++) {
  //     if (_number.toString().contains(_numberController.text[i])) {
  //       if (_numberController.text[i] == _number.toString()[i]) {
  //         _arti++;
  //       } else {
  //         _eksi++;
  //       }
  //     }
  //   }
  //   _guessProvider.addGuess(
  //     Guess(
  //       turn: _guessProvider.guesses.length + 1,
  //       number: int.parse(_numberController.text),
  //       plus: _arti,
  //       minus: _eksi,
  //     ),
  //   );
  //   _numberController.text = "";
  //   setState(() {});
  // }
}
