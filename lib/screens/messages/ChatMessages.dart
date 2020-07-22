import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:Fulltrip/widgets/ChatWidgets/ReceivedChatUI.dart';
import 'package:Fulltrip/widgets/ChatWidgets/SendedChatUI.dart';
import 'package:Fulltrip/data/models/ChatModel.dart';
import 'dart:async';

class ChatMessages extends StatefulWidget {
  ChatMessages({Key key}) : super(key: key);

  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  TextEditingController inputMessage = TextEditingController();
  ScrollController _controller = new ScrollController();
  bool emojis = false;
  List<Widget> chatMessages() {
    List<Widget> list = [];

    Global.chatmessages.forEach((element) {
      list.add(element.id == 1
          ? SendedMessageWidget(
              content: element.message,
            )
          : ReceivedMessageWidget(
              content: element.message,
            ));
    });
    if (list.length == 0) {
      list.add(Container(
        padding: EdgeInsets.only(left: 32, right: 32, top: 48),
        child: Center(
          child: Text(
            'No data Available',
            style: TextStyle(
                color: AppColors.greyColor, fontSize: 14, height: 1.8),
            textAlign: TextAlign.center,
          ),
        ),
      ));
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 200),
        () => _controller.jumpTo(_controller.position.maxScrollExtent));
  }

  Widget builMessageTextField() {
    return Column(
      children: [
        Visibility(
          visible: emojis,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: kElevationToShadow[4],
              ),
              width: double.infinity,
              padding: EdgeInsets.all(10),
              height: 150,
              duration: Duration(milliseconds: 500),
              child: Text('Here are the emojis'),
            ),
          ),
        ),
        Container(
          height: SizeConfig.blockSizeVertical * 10,
          decoration: BoxDecoration(
            boxShadow: kElevationToShadow[4],
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: inputMessage,
                      decoration: InputDecoration(
                          hintText: 'Écrire …', border: InputBorder.none),
                      onTap: () {
                        Timer(
                            Duration(milliseconds: 300),
                            () => _controller
                                .jumpTo(_controller.position.maxScrollExtent));
                      },
                      onSubmitted: (value) {
                        addNewMessage();
                      },
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.sentiment_satisfied,
                  color: AppColors.mediumGreyColor,
                ),
                onPressed: () => setState(() => emojis = !emojis),
              ),
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {
                  addNewMessage();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void addNewMessage() {
    if (inputMessage.text.trim().isNotEmpty) {
      setState(() {
        Global.chatmessages.add(ChatModel(message: inputMessage.text, id: 1));
        inputMessage.text = '';
      });
    }
    Timer(Duration(milliseconds: 300),
        () => _controller.jumpTo(_controller.position.maxScrollExtent));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: Text('Messages'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: ModalProgressHUD(
            inAsyncCall: Global.isLoading,
            color: AppColors.primaryColor,
            child: GestureDetector(
                onTap: () =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
                child: Container(
                    child: Stack(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                      Container(
                        height: SizeConfig.safeBlockVertical * 92,
                        padding: EdgeInsets.fromLTRB(16, 10, 16, 15),
                        child: ListView(
                            // reverse: true,
                            controller: _controller,
                            shrinkWrap: true,
                            children: chatMessages()),
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: builMessageTextField())
                    ]))),
          ),
        ));
  }
}
