import 'dart:io';

import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:eralpsoftware/eralpsoftware.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sayiciklar/blocs/authentication/authentication_bloc.dart';
import 'package:sayiciklar/blocs/login/login_bloc.dart';
import 'package:sayiciklar/helper/eralp_helper.dart';
import 'package:sayiciklar/repositories/user/user_repository.dart';
import 'package:sayiciklar/utils/device.dart';
import 'package:sayiciklar/utils/locator.dart';

MyDevice _myDevice = MyDevice();
UserRepository _userRepository = locator<UserRepository>();

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  File _image;
  final _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _usernameController.text = "";
    _passwordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccessState) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      child: _buildSignUpPage(context),
    );
  }

  GestureDetector _buildSignUpPage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: _myDevice.getDouble(160),
                    width: _myDevice.getDouble(160),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(600),
                    ),
                    child: InkWell(
                      onTap: () {
                        // _chooseImage();
                        _modalBottomSheetMenu();
                      },
                      borderRadius: BorderRadius.circular(600),
                      child: _image == null
                          ? Center(
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black,
                              ),
                            )
                          : ClipOval(
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Image(
                                  image: FileImage(
                                    File(_image.path),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                TextField(
                  controller: _fullnameController,
                  decoration: InputDecoration(
                    hintText: "fullname",
                  ),
                ),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: "username",
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "password",
                  ),
                  obscureText: true,
                ),
                _myDevice.sbh(8),
                InkWell(
                  onTap: () async {
                    EralpHelper.startProgress();
                    try {
                      final _imageUrl = await _uploadImage();
                      final _isSignedUp = await _userRepository.register(
                        {
                          "imageUrl": "$_imageUrl",
                          "fullname": "${_fullnameController.text}",
                          "username": "${_usernameController.text}",
                          "password": "${_passwordController.text}",
                        },
                      );
                      print("is signed up please tell me $_isSignedUp");
                      if (_isSignedUp) {
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginButtonPressed(
                            username: _usernameController.text,
                            password: _passwordController.text,
                          ),
                        );
                      } else {
                        FocusScope.of(context).unfocus();
                        Eralp.showSnackBar(
                          snackBar: SnackBar(
                            content: Text("Kayıt olunamadı"),
                          ),
                        );
                      }
                    } catch (e) {
                      print("an error occurred on signup: ${e.toString()}");
                    } finally {
                      EralpHelper.stopProgress();
                    }
                  },
                  child: Container(
                    height: _myDevice.getHeight(22),
                    width: _myDevice.getWidth(100),
                    child: Center(
                      child: Text(
                        "Kayıt ol",
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          fontSize: _myDevice.getDouble(18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _uploadImage() async {
    CloudinaryClient client = new CloudinaryClient(
        "392343226555615", "A5jscsB7xPBDCfw1wI28lCAICCE", "dso2r35l2");
    if (_image != null) {
      final response =
          await client.uploadImage(_image.path, filename: "deneme.jpeg");
      return response.url;
    }
    return "";
  }

  Future _chooseImage(ImageSource imageSource) async {
    var image = await _imagePicker.getImage(source: imageSource);
    if (image != null) {
      _image = File(image.path);
      setState(() {});
    }
  }

  void _modalBottomSheetMenu() {
    showBottomSheet(
      context: context,
      builder: (ctx) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(ctx);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(137, 137, 137, 1.0),
            ),
            child: Column(
              children: [
                Expanded(child: Container()),
                InkWell(
                  onTap: () async {
                    Navigator.pop(ctx);

                    await _chooseImage(ImageSource.gallery);
                  },
                  child: Container(
                    width: _myDevice.getWidth(392),
                    height: _myDevice.getHeight(62),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(224, 224, 224, 1.0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(_myDevice.getDouble(14)),
                        topRight: Radius.circular(_myDevice.getDouble(14)),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Galeriden Seç",
                        style: _text20.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: _myDevice.getWidth(392),
                  height: _myDevice.getHeight(1),
                  color: Color.fromRGBO(180, 180, 180, 1.0),
                ),
                InkWell(
                  onTap: () async {
                    Navigator.pop(ctx);

                    await _chooseImage(ImageSource.camera);
                  },
                  child: Container(
                    width: _myDevice.getWidth(392),
                    height: _myDevice.getHeight(62),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(224, 224, 224, 1.0),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(_myDevice.getDouble(14)),
                        bottomRight: Radius.circular(_myDevice.getDouble(14)),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Kamerayı Aç",
                        style: _text20.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _myDevice.getHeight(10),
                ),
                Container(
                  width: _myDevice.getWidth(392),
                  height: _myDevice.getHeight(62),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      _myDevice.getDouble(14),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "İptal",
                      style: _text20.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: _myDevice.padding.bottom + _myDevice.getHeight(52),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  TextStyle get _text20 => TextStyle(
        color: Color(0xff007AFF),
        fontSize: _myDevice.getWidth(20),
      );
}
