import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sayiciklar/helper/bloc_helper.dart';
import 'package:sayiciklar/models/guess.dart';
import 'package:sayiciklar/providers/game_provider.dart';

class PlayWithComputerPage extends StatefulWidget {
  PlayWithComputerPage({Key key}) : super(key: key);

  @override
  _PlayWithComputerPageState createState() => _PlayWithComputerPageState();
}

class _PlayWithComputerPageState extends State<PlayWithComputerPage> {
  TextEditingController _numberController;
  FocusNode _numberFocus;
  int _arti = 0;
  int _eksi = 0;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController();
    _numberFocus = FocusNode();
    _arti = 0;
    _eksi = 0;
  }

  @override
  Widget build(BuildContext context) {
    final _gameProvider = Provider.of<GameProvider>(context);
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
        body: Center(
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  focusNode: _numberFocus,
                  controller: _numberController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value.length != 4) {
                      return "Sayi 4 basamakli olmali";
                    }
                    if (value.length == 4) {
                      if (value[0] == "0") {
                        return "Sayinin ilk basamagi 0 olmamali";
                      }
                      for (var i = 0; i < value.length; i++) {
                        if (value[i].allMatches(value).length > 1) {
                          return "Sayilar tekrarlamamali";
                        }
                      }
                    }
                    return null;
                  },
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/guessPage");

                    // if (_form.currentState.validate()) {
                    //   _calculate(_gameProvider);
                    // } else {
                    //   FocusScope.of(context).requestFocus(_numberFocus);
                    // }
                  },
                  child: Text("Tahmin et"),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _gameProvider.guesses.length,
                    itemBuilder: (context, index) {
                      final _guess = _gameProvider.guesses[index];

                      return Card(
                        child: ListTile(
                          title: Text(
                              "${_guess.turn}. tahmininiz: ${_guess.number}"),
                          subtitle:
                              Text("Arti ${_guess.plus}\nEksi ${_guess.minus}"),
                          isThreeLine: true,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _calculate(GameProvider _gameProvider) {
    _arti = 0;
    _eksi = 0;
    for (var i = 0; i < 4; i++) {
      if (_gameProvider.number.toString().contains(_numberController.text[i])) {
        if (_numberController.text[i] == _gameProvider.number.toString()[i]) {
          _arti++;
        } else {
          _eksi++;
        }
      }
    }
    _gameProvider.addGuess(
      Guess(
        turn: _gameProvider.guesses.length + 1,
        number: int.parse(_numberController.text),
        plus: _arti,
        minus: _eksi,
      ),
    );
    _numberController.text = "";
    setState(() {});
  }
}
