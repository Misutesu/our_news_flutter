import 'package:flutter/material.dart';
import 'package:our_news_flutter/home.dart';
import 'package:our_news_flutter/type.dart';
import 'package:our_news_flutter/bean/new.dart';

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
  State<StatefulWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  var title = "OurNews";
  var themeData;

  @override
  void initState() {
    super.initState();

    themeData = ThemeData(primaryColor: Colors.blue);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "OurNews",
      theme: themeData,
      home: DefaultTabController(
          length: tabList.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  tooltip: '搜索',
                  onPressed: null,
                )
              ],
              bottom: TabBar(
                  isScrollable: true,
                  tabs: tabList.map((TabData tabData) {
                    return Tab(
                      text: tabData.title,
                    );
                  }).toList()),
            ),
            drawer: Drawer(
              child: Center(
                child: Text("Drawer"),
              ),
              elevation: 6,
            ),
            body: TabBarView(
                children: tabList.map((TabData tabData) {
              if (tabData.type == 0) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Test"),
                );
              } else {
                return TypeWidget(
                  key: Key(tabData.type.toString()),
                  tabData: tabData,
                );
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
  final List<New> newList = [];
}
