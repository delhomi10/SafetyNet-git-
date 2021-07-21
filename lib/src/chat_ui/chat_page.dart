
import 'package:abdelhomi/src/chat_ui/custom_card.dart';
import 'package:abdelhomi/src/chat_ui/select_contact.dart';
import 'package:abdelhomi/src/model/ChatModel.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {


  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chatModels = [
    ChatModel(
      name: "Dev Stack",
      isGroup: false,
      currentMessage: "Hi Everyone",
      time: "4:00",
      icon: "person.svg",
      id: 1,
    ),
    ChatModel(
      name: "Kishor",
      isGroup: false,
      currentMessage: "Hi Kishor",
      time: "13:00",
      icon: "person.svg",
      id: 2,
    ),
    ChatModel(
      name: "Collins",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "8:00",
      icon: "person.svg",
      id: 3,
    ),
    ChatModel(
      name: "Balram Rathore",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "2:00",
      icon: "person.svg",
      id: 4,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("ChatBox"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => SelectContact()));
        },
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: chatModels.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: chatModels[index],
          sourchat: chatModels[index],
        ),
      ),
    );
  }
}
