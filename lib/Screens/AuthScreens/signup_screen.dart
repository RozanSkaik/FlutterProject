import 'package:e_commerce_app/Data/database_helper.dart';
import 'package:e_commerce_app/Model/user.dart';
import 'package:e_commerce_app/Screens/AuthScreens/login_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState  extends State<SignUpScreen> {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _name, _email, _password,_type;

  String passwordValidation(value) {
      if (value.isEmpty) {
        return 'Password Required !!';
      }
    }

    String nameValidation(value) {
      if (value.isEmpty) {
        return 'Name Required !!';
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
    String typeValidation(value) {
      if (value.isEmpty) {
        return 'Type Required !!';
      }
    }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new Center(
        child: Container(
            margin: EdgeInsets.only(top: 30.0),
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
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
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
            "Sign Up",
            style: TextStyle(fontSize: 30.0),
          ),
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                child: TextFormField(
                  onSaved: (val) => _name = val,
                  validator: nameValidation,
                  decoration: InputDecoration(
                      labelText: "Name", border: OutlineInputBorder()),
                  minLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
                child: TextFormField(
                  onSaved: (val) => _email = val,
                  validator: emailValidation,
                  decoration: InputDecoration(
                    labelText: "Email", // Set text upper animation
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false, // Hiding words
                ),
              ),
              new Container(
                margin: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
                child: TextFormField(
                  onSaved: (val) => _password = val,
                  validator: passwordValidation,
                  decoration: InputDecoration(
                      labelText: "Password", border: OutlineInputBorder()),
                  minLines: 1,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  obscureText: true,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
                child: TextFormField(
                  onSaved: (val) => _type = val,
                  validator: typeValidation,
                  decoration: InputDecoration(
                    labelText: "Type", // Set text upper animation
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
        ),
        loginBtn
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

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  void _submit(){
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        var user = new User(_name, _email, _password, null,_type);
        print(user.type+"*******");
        var db = new DatabaseHelper();
        db.saveUser(user);
        _isLoading = false;
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }
  }
}