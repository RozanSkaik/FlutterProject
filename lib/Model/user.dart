class User {
  String _name;
  String _username;
  String _password;
  String _flaglogged;
  String _type;

  
  User(this._name, this._username, this._password,this._flaglogged,this._type );

  User.map(dynamic obj) {
    this._name = obj['name'];
    this._username = obj['username'];
    this._password = obj['password'];
    this._flaglogged = obj['password'];
    this._type = obj['type'];
  }

  String get name => _name;
  String get username => _username;
  String get password => _password;
  String get type => _type;
  String get flaglogged => _flaglogged;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["username"] = _username;
    map["password"] = _password;
    map["flaglogged"] = _flaglogged;
    map["type"] = _type;
    return map;
  }
}
