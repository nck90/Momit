import 'package:flutter/material.dart';

class ChatListPage extends StatelessWidget {
  final List<Map<String, String>> chatList = [
    {
      'name': '하이톤 운영진',
      'lastMessage': '죄송합니다. 신청 취소 가능한가요?',
      'time': '11월 23일',
      'unread': '0',
    },
    {
      'name': '서울디자인재단',
      'lastMessage': '감사합니다.',
      'time': '11월 12일',
      'unread': '1',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "채팅",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          final chat = chatList[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(chat['name']![0]),
            ),
            title: Text(chat['name']!),
            subtitle: Text(chat['lastMessage']!),
            trailing: Text(chat['time']!),
          );
        },
      ),
    );
  }
}
