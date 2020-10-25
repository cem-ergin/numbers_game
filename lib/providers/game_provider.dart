import 'package:flutter/material.dart';
import 'package:sayiciklar/helper/number_helper.dart';
import 'package:sayiciklar/models/guess.dart';

class GameProvider with ChangeNotifier {
  int _number = NumberHelper.getMyFourNumberDigit();
  int get number => _number;
  set number(int number) {
    _number = number;
    notifyListeners();
  }

  final List<Guess> _guesses = [];
  List<Guess> get guesses => _guesses;
  void addGuess(Guess guess) {
    _guesses.add(guess);
    print("guess added: $guess");
  }
}
