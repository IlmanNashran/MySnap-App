import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  double? _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _titleWidget(),
              _registerButton(),
            ],
          ),
        ),
      ),
    );
  }

// create title function
  Widget _titleWidget() {
    return const Text(
      "Snap App",
      style: TextStyle(
          color: Colors.black, fontSize: 40, fontWeight: FontWeight.w500),
    );
  }

  //register button
  Widget _registerButton() {
    return MaterialButton(
      onPressed: () {},
      minWidth: _deviceWidth! * 0.50,
      height: _deviceHeight! * 0.05,
      color: Colors.red,
      child: const Text(
        "Register",
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
      ),
    );
  }
}
