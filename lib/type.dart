import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class TypeWidget extends StatefulWidget {
  @override
  _TypeWidgetState createState() => _TypeWidgetState();
}

class _TypeWidgetState extends State<TypeWidget> {
  var isInit = false;
  var page = 1;

  @override
  void initState() {
    super.initState();

    loadData(page);
  }

  @override
  Widget build(BuildContext context) {
    if (!isInit) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return new RefreshIndicator(
          onRefresh: () {
            final Completer<Null> completer = new Completer<Null>();
            setState(() {});
            completer.complete(null);
            return completer.future;
          },
          child: new ListView.builder(
            physics: new AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                onTap: null,
                child: new Row(
                  children: <Widget>[
                    new Text('Title1'),
                    new Text('Title2'),
                    new Text('Title3'),
                  ],
                ),
              );
            },
          ));
    }
  }

  loadData(int page) async {
    var values = <String>[];
    var httpClient = new HttpClient();
    var uri = new Uri.http('http://119.29.58.134/OurNews/', 'getNewList',
        {'type': '1', 'page': page.toString(), 'size': '10', 'sort': '1'});
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.join();
    setState(() {
      isInit = true;
    });
  }
}
