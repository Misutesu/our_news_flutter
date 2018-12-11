import 'package:flutter/material.dart';
import 'package:our_news_flutter/home.dart';
import 'package:our_news_flutter/type.dart';

void main() => runApp(new TabWidget());

List<TabData> tabList = <TabData>[
  TabData(type: 0, title: '推荐'),
  TabData(type: 1, title: 'ACG'),
  TabData(type: 2, title: '游戏'),
  TabData(type: 3, title: '社会'),
  TabData(type: 4, title: '娱乐'),
  TabData(type: 5, title: '科技'),
];

var temp = new TabData(type: 1, title: "");

class TabWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TabWidgetState();
  }
}

class _TabWidgetState extends State<TabWidget> {
  var title = "OurNews";
  var themeData;

  @override
  void initState() {
    super.initState();

    themeData = new ThemeData(primaryColor: Colors.blue);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "OurNews",
      theme: themeData,
      home: new DefaultTabController(
          length: tabList.length,
          child: new Scaffold(
            appBar: new AppBar(
              title: new Text(title),
              actions: <Widget>[
                new IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  tooltip: 'Search',
                  onPressed: null,
                )
              ],
              bottom: new TabBar(
                  isScrollable: true,
                  tabs: tabList.map((TabData tabData) {
                    return new Tab(
                      text: tabData.title,
                    );
                  }).toList()),
            ),
            body: new TabBarView(
                children: tabList.map((TabData tabData) {
              if (tabData.type == 0) {
                return new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new Text("Test"),
                );
              } else {
                return new TypeWidget(tabData.type);
              }
            }).toList()),
          )),
    );
  }
}

class TabData {
  TabData({this.type, this.title});

  final int type;
  final String title;
}
