import 'dart:math';

class NumberHelper {
  static int getMyFourNumberDigit() {
    int _myNumber = 0;
    final List<int> _myInts = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    int _randomNumber = Random().nextInt(9);
    _myNumber += _myInts[_randomNumber] * 1000;
    _myInts.removeAt(_randomNumber);
    _myInts.add(0);
    _randomNumber = Random().nextInt(9);
    _myNumber += _myInts[_randomNumber] * 100;
    _myInts.removeAt(_randomNumber);
    _randomNumber = Random().nextInt(8);
    _myNumber += _myInts[_randomNumber] * 10;
    _myInts.removeAt(_randomNumber);
    _randomNumber = Random().nextInt(7);
    _myNumber += _myInts[_randomNumber] * 1;
    _myInts.removeAt(_randomNumber);

    final String _testString = _myNumber.toString();
    for (var i = 0; i < _testString.length; i++) {
      if (_testString[i].allMatches(_testString).length > 1) {
        return getMyFourNumberDigit();
      }
    }
    return _myNumber;
  }
}
