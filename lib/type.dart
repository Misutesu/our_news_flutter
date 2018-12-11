import 'package:flutter/material.dart';
import 'dart:async';
import 'package:our_news_flutter/utils/dio_utils.dart';
import 'package:our_news_flutter/api.dart';
import 'package:our_news_flutter/bean/new.dart';

final int size = 10;
final int sort = 1;

int pageType;

class TypeWidget extends StatefulWidget {
  TypeWidget(int type) {
    pageType = type;
  }

  @override
  _TypeWidgetState createState() => _TypeWidgetState();
}

class _TypeWidgetState extends State<TypeWidget> {
  var isInit = false;
  var page = 1;
  List<New> newList = [];

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
      print("TAG length : " + newList.length.toString());
      return new RefreshIndicator(
          onRefresh: () {
            final Completer<Null> completer = new Completer<Null>();
            setState(() {});
            completer.complete(null);
            return completer.future;
          },
          child: new ListView.builder(
            physics: new AlwaysScrollableScrollPhysics(),
            itemCount: newList.length,
            itemBuilder: (BuildContext context, int position) {
              New newBean = newList[position];
              return new GestureDetector(
                onTap: null,
                child: new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Row(
                    children: <Widget>[
                      new Image.network(
                        baseUrl + imgUrl + newBean.cover,
                        width: 160,
                        height: 100,
                      ),
                      new Text('Title2'),
                      new Text('Title3'),
                    ],
                  ),
                ),
              );
            },
          ));
    }
  }

  loadData(int page) async {
    try {
      var response = await DioUtils.dio.get(getNewList, data: {
        'type': pageType,
        'page': page,
        'size': size,
        'sort': sort,
      });
      newList.addAll(New.decodeData(response.data.toString()));
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      isInit = true;
    });
  }
}
