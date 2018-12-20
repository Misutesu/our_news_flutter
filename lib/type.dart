import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'package:our_news_flutter/main.dart';
import 'package:our_news_flutter/utils/dio_utils.dart';
import 'package:our_news_flutter/api.dart';
import 'package:our_news_flutter/bean/new.dart';

const int TYPE_LOAD = 0;
const int TYPE_HINT = 1;
const int TYPE_NORMAL = 2;

const int size = 20;
const int sort = 1;

class TypeWidget extends StatefulWidget {
  final TabData tabData;

  const TypeWidget({Key key, this.tabData}) : super(key: key);

  @override
  _TypeWidgetState createState() {
    return _TypeWidgetState(tabData);
  }
}

class _TypeWidgetState extends State<TypeWidget> {
  int pageState = TYPE_LOAD;

  TabData tabData;
  int page = 1;

  _TypeWidgetState(this.tabData);

  @override
  void initState() {
    super.initState();
    if (pageState == TYPE_LOAD) {
      _loadData(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (pageState) {
      case TYPE_LOAD:
        return Center(
          child: CircularProgressIndicator(),
        );
      case TYPE_HINT:
        return Center(
          child: RaisedButton(
            onPressed: () {
              setState(() {
                pageState = TYPE_LOAD;
              });
              _loadData(true);
            },
            color: Theme.of(context).primaryColor,
            child: Text(
              "重试",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
    }
    return new RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: tabData.newList.length,
          itemBuilder: (BuildContext context, int position) {
            New newBean = tabData.newList[position];
            return InkWell(
              onTap: null,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
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
                    Text(newBean.title),
//                    Expanded(
//                      child: Stack(
//                        children: <Widget>[
//                          Positioned(
//                            top: 0,
//                            child: Text(newBean.title),
//                          ),
//                          Positioned(
//                            bottom: 0,
//                            child: Text(newBean.createTime),
//                          ),
//                        ],
//                      ),
//                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  Future<Null> _onRefresh() {
    page = 1;
    return _loadData(true);
  }

  Future<Null> _loadData(bool refresh) async {
    final Completer<Null> completer = Completer<Null>();
    try {
      var response = await DioUtils.dio.get(getNewList, data: {
        'type': tabData.type,
        'page': page,
        'size': size,
        'sort': sort,
      });
      if (refresh) {
        tabData.newList.clear();
      }
      tabData.newList.addAll(New.decodeData(response.data.toString()));
      setState(() {
        pageState = TYPE_NORMAL;
      });
    } catch (e) {
      print("LoadError:${e.toString()}");
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: Text("Load News Error"),
      ));
      if (refresh) {
        tabData.newList.clear();
      }
      if (tabData.newList.isEmpty) {
        setState(() {
          pageState = TYPE_HINT;
        });
      }
    }

    completer.complete(null);
    return completer.future;
  }
}
