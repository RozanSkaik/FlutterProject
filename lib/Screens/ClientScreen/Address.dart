import 'package:flutter/material.dart';
import 'dbmanager.dart';



class AddressScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AddressScreen> {
  final DbAddressManager dbmanager = new DbAddressManager();

  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  Address student;
  List<Address> studlist;
  int updateIndex;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: new InputDecoration(labelText: 'Name'),
                    controller: _nameController,
                    validator: (val) =>
                    val.isNotEmpty ? null : 'Name Should Not Be empty',
                  ),
                  TextFormField(
                    decoration: new InputDecoration(labelText: 'City'),
                    controller: _cityController,
                    validator: (val) =>
                    val.isNotEmpty ? null : 'City Should Not Be empty',
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    child: Container(
                        width: width * 0.9,
                        child: Text(
                          'Add Address',
                          textAlign: TextAlign.center,
                        )),
                    onPressed: () {
                      _submitAddress(context);
                    },
                  ),
                  FutureBuilder(
                    future: dbmanager.getAddressList(),
                    builder: (context,snapshot){
                      if(snapshot.hasData) {
                        studlist = snapshot.data;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: studlist == null ?0 : studlist.length,
                          itemBuilder: (BuildContext context, int index) {
                            Address st = studlist[index];
                            return Card(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: width*0.6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Name: ${st.name}',style: TextStyle(fontSize: 15),),
                                        Text('City: ${st.city}', style: TextStyle(fontSize: 15, color: Colors.black54),),
                                      ],
                                    ),
                                  ),

                                  IconButton(onPressed: (){
                                    _nameController.text=st.name;
                                    _cityController.text=st.city;
                                    student=st;
                                    updateIndex = index;
                                  }, icon: Icon(Icons.edit, color: Colors.blueAccent,),),
                                  IconButton(onPressed: (){
                                    dbmanager.deleteAddress(st.id);
                                    setState(() {
                                      studlist.removeAt(index);
                                    });
                                  }, icon: Icon(Icons.delete, color: Colors.red,),)

                                ],
                              ),
                            );
                          },

                        );
                      }
                      return new CircularProgressIndicator();
                    },
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitAddress(BuildContext context) {
    if(_formKey.currentState.validate()){
      if(student==null) {
        Address st = new Address(name: _nameController.text, city: _cityController.text);
        dbmanager.insertAddress(st).then((id)=>{
          _nameController.clear(),
          _cityController.clear(),
          print('Student Added to Db ${id}')
        });
      } else {
        student.name = _nameController.text;
        student.city = _cityController.text;

        dbmanager.updateAddress(student).then((id) =>{
          setState((){
            studlist[updateIndex].name = _nameController.text;
            studlist[updateIndex].city= _cityController.text;
          }),
          _nameController.clear(),
          _cityController.clear(),
          student=null
        });
      }
    }
  }
}