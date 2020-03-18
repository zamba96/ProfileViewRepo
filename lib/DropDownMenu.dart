import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  //DropDownMenu({Key key}) : super(key: key);

  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String dropdownValue = 'Juan';
  String name = '';
  String edad = '';
  String peso = '';

  void getDropDownItem() {
    setState(() {
      name = dropdownValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    getDropDownItem();
    if (name == 'Juan') {
      setState(() {
        edad = '20 Meses';
        peso = '10 Kg';
      });
    } else if (name == 'Laura') {
      setState(() {
        edad = '10 Meses';
        peso = '8 Kg';
      });
    }
    return Container(
      //Info del nino
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('$name', style: TextStyle(fontSize: 26))
                ],
              ),
              Row(
                children: <Widget>[Text('$edad')],
              ),
              Row(
                children: <Widget>[Text('$peso')],
              )
            ],
          ),
          Container(
              padding: EdgeInsets.only(left: 25),
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Escoje el perfil',
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                Row(children: <Widget>[
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.orange),
                    underline: Container(
                      height: 2,
                      color: Colors.orange,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['Juan', 'Laura']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ])
              ]))
        ],
      ),
    );
  }
}
