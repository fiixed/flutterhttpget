import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' show get;
import 'dart:convert';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  final String url = 'https://swapi.co/api/people';
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response =
        await get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    print(response.body);
    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['results'];
    });
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Json vis HTTP Get'),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(data[index]['name']),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
