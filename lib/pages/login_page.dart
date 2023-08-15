import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  double? _deviceWidth, _deviceHeight;

  final GlobalKey<FormState> _loginFormKey =
      GlobalKey<FormState>(); //create variable for form  name "_loginFormKey"

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _titleWidget(),
                _loginForm(),
                _loginButton(),
                _registerPageLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //funtion for showing title
  Widget _titleWidget() {
    return const Text(
      "Snap App",
      style: TextStyle(
          color: Colors.black, fontSize: 40, fontWeight: FontWeight.w500),
    );
  }

  //fucntion for showing button login
  Widget _loginButton() {
    return MaterialButton(
      onPressed: _loginUser,
      minWidth: _deviceWidth! * 0.70,
      height: _deviceHeight! * 0.06,
      color: Colors.red,
      child: const Text(
        "Login",
        style: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _registerPageLink() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'register'),
      child: const Text(
        "Dont have an account?",
        style: TextStyle(
            color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w400),
      ),
    );
  }

//form widget
  Widget _loginForm() {
    return Container(
      height: _deviceHeight! * 0.20,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _emailTextField(),
            _passwordTextField(),
          ],
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(hintText: "Email...."),
      onSaved: (_value) {
        setState(() {
          _email = _value;
        });
      },
      validator: (_value) {
        bool _result = _value!.contains(
          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'),
        );
        return _result ? null : "Please enter a valid email";
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      obscureText: true, //unseen the password
      decoration: const InputDecoration(hintText: "Password...."),
      onSaved: (_value) {
        setState(() {
          _email = _value;
        });
      },
      validator: (_value) =>
          _value!.length > 6 ? null : "Please enter a valid password",
    );
  }

  void _loginUser() {
    //print(_loginFormKey.currentState!.validate());   // for checking the validate  //calling validator() function
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
    } else {}
  }
}
