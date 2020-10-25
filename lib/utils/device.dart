import 'package:eralpsoftware/eralpsoftware.dart';
import 'package:flutter/material.dart';

class MyDevice {
  static final MyDevice _instance = MyDevice._internal();

  factory MyDevice() {
    return _instance;
  }

  MyDevice._internal() {
    print("DeviceConfig oluşturuldu");
  }

  Size _size;
  Size get size => _size;

  void setSize(Size size) {
    _size = size;
  }

  EdgeInsets _padding;
  EdgeInsets get padding => _padding;
  set padding(EdgeInsets padding) {
    _padding = padding;
    print("padding setted");
  }

  Size _xdScreenSize = Size(414, 896);

  double getDouble(double val) => XdHelper.getScaledDouble(
        size: _size,
        xdDouble: val,
        xdScreenSize: _xdScreenSize,
      );

  Size getSize(Size val) => XdHelper.getScaledSize(
        size: _size,
        xdContainerSize: val,
        xdScreenSize: _xdScreenSize,
      );

  double getHeight(double val) => XdHelper.getScaledSize(
        size: _size,
        xdContainerSize: Size(1, val),
        xdScreenSize: _xdScreenSize,
      ).height;

  double getWidth(double val) => XdHelper.getScaledSize(
        size: _size,
        xdContainerSize: Size(val, 1),
        xdScreenSize: _xdScreenSize,
      ).width;

  SizedBox sbh(double height) => SizedBox(height: getHeight(height));

  SizedBox sbw(double width) => SizedBox(width: getHeight(width));
}
