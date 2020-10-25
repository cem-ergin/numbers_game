import 'package:flutter/material.dart';

class Guess {
  final int number;
  final int plus;
  final int minus;
  final int turn;

  Guess({
    @required this.turn,
    @required this.number,
    @required this.plus,
    @required this.minus,
  });
}
