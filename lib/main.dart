// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'MyChart.dart';
import 'MySeries.dart';
import 'DropDownMenu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '0A5',
      home: ProfileView(),
    );
  }
}

const mainColor = Colors.orange;

class ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: mainColor,
      ),
      body: _buildBody(context),
    );
  }

  //Solo para testear
  Widget _testStar() {
    return Icon(
      Icons.star,
      color: Colors.red[200],
    );
  }

  //La lista de prueba de datos para la grafica
  final List<MySeries> testList = [
    MySeries(
        category: "Cognitivo",
        color: charts.ColorUtil.fromDartColor(Colors.green),
        number: 2),
    MySeries(
        category: "Motriz",
        color: charts.ColorUtil.fromDartColor(Colors.blue),
        number: 3),
    MySeries(
        category: "Lenguaje",
        color: charts.ColorUtil.fromDartColor(Colors.orange),
        number: 5),
    MySeries(
        category: "Sensorial",
        color: charts.ColorUtil.fromDartColor(Colors.purple),
        number: 6),
  ];

  //Pinta el container con la imagen del nino y su info
  Widget _buildInfoNino(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Columna Imagen
            Column(
              children: <Widget>[
                Icon(
                  Icons.child_care,
                  size: 100.0,
                ),
              ],
            ),
            Column(children: <Widget>[DropDownMenu()]),
          ],
        ));
  }

  //Deffault Shadow
  BoxShadow boxShadow2 = BoxShadow(
      color: Colors.black54, blurRadius: 4.0, offset: Offset(1.75, 1.75));

  //Construye el counter de actividades, donde dice cuantas va y que porcentaje
  Widget _buildCounterActividades(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: mainColor[100],
          boxShadow: <BoxShadow>[boxShadow2],
          //borderRadius: new BorderRadius.all(new Radius.circular(10.0))
        ),
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Icono
            Icon(Icons.golf_course, color: Colors.green[400], size: 100),
            //Column con los datos, adentro vienen rows con el numero de actividades y el porcentaje
            Column(children: [
              //Banner Actividades
              Text('Actividades',
                  style: TextStyle(
                      fontSize: 25.0,
                      color: mainColor,
                      fontWeight: FontWeight.bold)),
              Text('5/15',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: mainColor,
                      fontWeight: FontWeight.bold)),
              Text('33%',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.green[400],
                      fontWeight: FontWeight.bold)),
            ])
          ],
        ));
  }

  //Pinta el resumen de actividades que dice actividades, el numero que va y el porcentaje
  Widget _buildBody(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey[200],
        ),
        child: ListView(children: [
          //Row con la info del nini
          _buildInfoNino(context),
          //Row que dice Resumen Semanal
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: mainColor,
                    boxShadow: [boxShadow2],
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(10.0))),
                child: Text("Resumen Semanal",
                    style: TextStyle(fontSize: 30.0, color: Colors.white)),
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.all(5.0),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          //Row que pinta el porcentaje semanal
          _buildCounterActividades(context),
          //Agrega la primera grafica
          Container(child: MyBarChart(data: testList)),
        ]));
  }
}

class ProfileView extends StatefulWidget {
  @override
  ProfileViewState createState() => ProfileViewState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generatos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          ),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
            return ListTile(
              title: Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          });
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
