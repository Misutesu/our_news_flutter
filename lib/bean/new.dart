import 'dart:convert';
import 'package:our_news_flutter/bean/manager_user.dart';

class New {
  int id;
  String title;
  String cover;
  String abstractContent;
  String content;
  String createTime;
  int type;
  int isCollection;
  int commentNum;
  int historyNum;
  int collectionNum;
  ManagerUser managerUser;

  New(
      {this.id,
      this.title,
      this.cover,
      this.abstractContent,
      this.content,
      this.createTime,
      this.type,
      this.isCollection,
      this.commentNum,
      this.historyNum,
      this.collectionNum,
      this.managerUser});

  static List<New> decodeData(String jsonData) {
    List<New> news = [];
    Map<String, dynamic> data = json.decode(jsonData);

    var newsData = data['data']['news'];
    for (var newData in newsData) {
      var managerData = newData['manager'];
      news.add(New(
          id: newData['id'],
          title: newData['title'],
          cover: newData['cover'],
          abstractContent: newData['abstract'],
          content: newData['content'],
          createTime: newData['create_time'],
          type: int.parse(newData['type']),
          collectionNum: newData['collection_num'],
          historyNum: newData['history_num'],
          managerUser: ManagerUser(
              id: managerData['id'],
              nickName: managerData['nick_name'],
              sex: managerData['sex'],
              sign: managerData['sign'],
              birthday: managerData['birthday'],
              photo: managerData['photo'])));
    }
    return news;
  }
}
