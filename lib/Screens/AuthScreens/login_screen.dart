import 'package:e_commerce_app/Data/database_helper.dart';
import 'package:e_commerce_app/Model/user.dart';
import 'package:e_commerce_app/Screens/AuthScreens/signup_screen.dart';
import 'package:e_commerce_app/Screens/ClientScreen/Home.dart';
import 'package:e_commerce_app/Screens/MershatScreens/m_home_screen.dart';
import 'package:e_commerce_app/Screens/auth_screen.dart';
import 'package:flutter/material.dart';

import 'login_response.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> implements LoginPageContract {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _email, _password,_type;

  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  void _register() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  String passwordValidation(value) {
    if (value.isEmpty) {
      return 'Password Required !!';
    }
  }

  String emailValidation(value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (value.isEmpty) {
      return 'Email Required !!';
    } else if (!emailValid) {
      return 'This is email not correct !';
    }
  }
   Future<void> getType() async {
     DatabaseHelper db = new DatabaseHelper();
     User user = User(null, _email, _password, null, null);
     List<Map> list = await db.selectUserType(user);
     _type = list.map((e) => e['type'] as String).toString().replaceAll("(", "").replaceAll(")", "");
  }

   _submit()  {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
         getType();
        _presenter.doLogin(_email, _password,_type);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new Center(
        child: Container(
            margin: EdgeInsets.only(top: 50.0),
            child: RaisedButton(
              onPressed: () {
                _submit();
              }, // When Click on Button goto Login Screen

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              padding: const EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [new Color(0xff374ABE), new Color(0xff64B6FF)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Container(
                  constraints: const BoxConstraints(
                      maxWidth: 300.0,
                      minHeight: 40.0), // min sizes for Material buttons
                  alignment: Alignment.center,
                  child: const Text(
                    'Log in',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )));
    var registerBtn = new Center(
        child: Container(
            padding: EdgeInsets.only(bottom: 30.0),
            margin: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't Have any account? "),
                GestureDetector(
                  child: Text(
                    "  Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpScreen()));
                  },
                )
              ],
            )));
    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Login Back Button Section
        Container(
            margin: EdgeInsets.only(left: 10.0, top: 50.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.keyboard_backspace,
                color: Color(0xffc5ccd6),
                size: 30.0,
              ),
            )),

        // Login Text Section
        Container(
          margin: EdgeInsets.only(top: 20.0, left: 30.0),
          child: Text(
            "Login",
            style: TextStyle(fontSize: 30.0),
          ),
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
                child: TextFormField(
                  onSaved: (val) => _email = val,
                  validator: emailValidation,
                  decoration: InputDecoration(
                      labelText: "Email", border: OutlineInputBorder()),
                  minLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
                child: TextFormField(
                  onSaved: (val) => _password = val,
                  validator: passwordValidation,
                  decoration: InputDecoration(
                    labelText: "Password", // Set text upper animation
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  obscureText: true, // Hiding words
                ),
              ),
            ],
          ),
        ),
        new Padding(padding: const EdgeInsets.all(10.0), child: loginBtn),

        registerBtn
      ],
    );

    return new Scaffold(
      key: scaffoldKey,
      body: ListView(
        children: <Widget>[
          new Container(
            child: new Center(
              child: loginForm,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar("Login not successful");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    if (user.username == "") {
      _showSnackBar("Login not successful");
    } else {
      _showSnackBar(user.username);
    }
    setState(() {
      _isLoading = false;
    });
    if (user.flaglogged == "logged") {
      print("Logged");
      if(_type == "merchant"){
        Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MershantHomeScreen()));
      }else if(_type == "client"){
        Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));
      }
    } else {
      print("Not Logged");
    }
  }
}
