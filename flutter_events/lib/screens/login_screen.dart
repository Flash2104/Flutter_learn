import 'package:flutter/material.dart';
import 'package:flutter_events/shared/auth.dart';

import 'event_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogin = true;
  String _userId;
  String _password;
  String _email;
  String _message = '';

  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtPassword = TextEditingController();

  Authentication _auth;

  @override
  void initState() {
    _auth = Authentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход'),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [_emailInput(), _passwordInput(), _mainButton(), _secondaryButton(), _validationMessage()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: TextFormField(
        controller: _txtEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(hintText: 'email', icon: Icon(Icons.email)),
        validator: (value) => value.isEmpty ? 'Email обязателен' : null,
      ),
    );
  }

  Widget _passwordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: TextFormField(
        controller: _txtPassword,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(hintText: 'пароль', icon: Icon(Icons.enhanced_encryption)),
        validator: (value) => value.isEmpty ? 'Пароль обязателен' : null,
      ),
    );
  }

  Widget _mainButton() {
    String buttonText = _isLogin ? 'Войти' : 'Регистрация';
    return Padding(
        padding: EdgeInsets.only(top: 120),
        child: Container(
            height: 50,
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Theme.of(context).accentColor,
              elevation: 3,
              child: Text(buttonText),
              onPressed: _submit,
            )));
  }

  Widget _secondaryButton() {
    String buttonText = !_isLogin ? 'Вход' : 'Регистрация';
    return FlatButton(
      child: Text(buttonText),
      onPressed: () {
        setState(() {
          _isLogin = !_isLogin;
        });
      },
    );
  }

  Widget _validationMessage() {
    return Text(
      _message,
      style: TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
    );
  }

  Future _submit() async {
    setState(() {
      _message = '';
    });

    try {
      if (_isLogin) {
        _userId = await _auth.login(_txtEmail.text, _txtPassword.text);
        print('Login for user $_userId');
      } else {
        _userId = await _auth.signUp(_txtEmail.text, _txtPassword.text);
        print('Sign up for user $_userId');
      }
      if (_userId != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EventScreen(_userId)));
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _message = e.message;
      });
    }
  }
}
