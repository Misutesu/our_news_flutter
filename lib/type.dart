import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'package:our_news_flutter/main.dart';
import 'package:our_news_flutter/utils/dio_utils.dart';
import 'package:our_news_flutter/api.dart';
import 'package:our_news_flutter/bean/new.dart';

TabData tabData;

final int size = 20;
final int sort = 1;
int page = 1;

var isInit = false;
List<New> newList = [];

class TypeWidget extends StatefulWidget {
  TypeWidget(TabData tab) {
    tabData = tab;
  }

  @override
  _TypeWidgetState createState() => _TypeWidgetState();
}

class _TypeWidgetState extends State<TypeWidget> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    if (!isInit) {
      Future.delayed(Duration(milliseconds: 500), () {
        _refreshIndicatorKey.currentState.show();
      });
    }
    return new RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
        child: new ListView.builder(
          physics: new AlwaysScrollableScrollPhysics(),
          itemCount: newList.length,
          itemBuilder: (BuildContext context, int position) {
            New newBean = newList[position];
            return new InkWell(
              onTap: null,
              child: new Padding(
                padding: const EdgeInsets.all(8),
                child: new Row(
                  children: <Widget>[
                    new ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: new CachedNetworkImage(
                        imageUrl: baseUrl + imgUrl + newBean.cover,
                        fit: BoxFit.cover,
                        width: 160,
                        height: 108,
                        errorWidget: Image.asset(
                          "assets/default_img.png",
                          fit: BoxFit.cover,
                          width: 160,
                          height: 108,
                        ),
                      ),
                    ),
                    new Text(newBean.title),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Future<Null> _onRefresh() {
    page = 1;
    return _loadData();
  }

  Future<Null> _loadData() async {
    final Completer<Null> completer = new Completer<Null>();
    try {
      var response = await DioUtils.dio.get(getNewList, data: {
        'type': tabData.type,
        'page': page,
        'size': size,
        'sort': sort,
      });
      newList.addAll(New.decodeData(response.data.toString()));
    } catch (e) {
      print(e.toString());
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text("Load News Error"),
      ));
    }

    setState(() {
      isInit = true;
    });

    completer.complete(null);
    return completer.future;
  }
}
