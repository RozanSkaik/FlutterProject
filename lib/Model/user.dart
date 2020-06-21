class User {
  String id;
  String _name;
  String _username;
  String _password;
  String _flaglogged;
  String _type;

  
  User(this._name, this._username, this._password,this._flaglogged,this._type );

  User.fromJson(Map<String,dynamic> map, String id):this.id = id ?? ''
  ,this._name = map['name'],
    this._username = map['email'],
    this._password = map['password'],
    this._type = map['type'];
  toJson(){
    return{
      'id':id,
      'name':_name,
      'email':_username,
      'password':_password,
      'type':_type,
    };
  }

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
