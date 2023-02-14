import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double? _deviceHeight, _deviceWidth;
  FirebaseService? _firebaseService;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.2),
          child: Center(
            child: Column(children: <Widget>[
              //_titleWidget(),
              _loginForm(),
              const SizedBox(height: 30),
              _loginButton(),
              const SizedBox(height: 30),
              _registerPageLink(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return MaterialButton(
      minWidth: _deviceWidth! * 0.70,
      height: _deviceHeight! * 0.05,
      color: Colors.blue,
      onPressed: _loginUser,
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }

  Widget _registerPageLink() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'register'),
      child: const Text(
        "Don't have an account",
        style: TextStyle(color: Colors.blue, fontSize: 20),
      ),
    );
  }

  void _loginUser() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      bool _result =
          await _firebaseService!.loginUser(email: _email!, password: _password!);
      if (_result) {
        Navigator.popAndPushNamed(context, 'home');
      } else {
        Fluttertoast.showToast(
            msg: "Login failed",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      ;
    }
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text(
        'Finstagram',
        style: TextStyle(fontSize: 45),
      ),
      centerTitle: true,
    );
  }

  Widget _loginForm() {
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        height: _deviceHeight! * .23,
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: <Widget>[
              _emailTextField(),
              _passwordTextField(),
            ],
          ),
        ));
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Email',
        labelStyle: TextStyle(color: Colors.red, fontSize: 20),
      ),
      validator: (value) =>
          EmailValidator.validate(value!) ? null : 'Enter a valid email',
      onSaved: (value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      obscureText: _isObscure,
      decoration: InputDecoration(
        hintText: 'Password',
        labelStyle: const TextStyle(color: Colors.red, fontSize: 20),
        suffixIcon: IconButton(
          icon: _isObscure
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
      ),
      validator: (String? value) =>
          value!.length > 5 ? null : 'Password must be greater than 5 characters',
      onSaved: (value) {
        setState(() {
          _password = value;
        });
      },
    );
  }
}
