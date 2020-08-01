import 'dart:async';

import 'package:Fulltrip/data/models/ChatModel.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/ChatWidgets/ReceivedChatUI.dart';
import 'package:Fulltrip/widgets/ChatWidgets/SendedChatUI.dart';
import 'package:Fulltrip/widgets/form_field_container/form_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ChatMessages extends StatefulWidget {
  ChatMessages({Key key}) : super(key: key);

  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages>
    with SingleTickerProviderStateMixin {
  TextEditingController inputMessage = TextEditingController();
  ScrollController _controller = new ScrollController();
  bool emojis = false;
  AnimationController _containerController;
  bool isVisible = true;

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

    scrollListner();
  }

  scrollListner() {
    _controller.addListener(() {
      if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isVisible)
          setState(() {
            isVisible = true;
          });
      }
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        if (isVisible)
          setState(() {
            isVisible = false;
          });
      }
    });
  }

  Widget builMessageTextField() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file, color: Colors.black),
                  onPressed: () => setState(() {
                    FocusScope.of(context).unfocus();
                    emojis = !emojis;
                  }),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: FormFieldContainer(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: AppColors.lightGreyColor.withOpacity(0.6)),
                      ),
                      child: TextField(
                        controller: inputMessage,
                        enabled: true,
                        minLines: 1,
                        maxLines: 5,
                        textInputAction: TextInputAction.newline,
                        maxLengthEnforced: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(5)),
                        onTap: () {
                          Timer(
                              Duration(milliseconds: 300),
                              () => _controller.jumpTo(
                                  _controller.position.maxScrollExtent));
                          setState(() {
                            emojis = false;
                          });
                        },
                        onSubmitted: (value) {
                          addNewMessage();
                        },
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor, shape: BoxShape.circle),
                    child: Center(
                        child: Icon(Icons.arrow_upward,
                            size: 26, color: Colors.white)),
                  ),
                  onPressed: () {
                    addNewMessage();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimatedContainer(
              width: emojis ? SizeConfig.screenWidth : 0,
              padding: EdgeInsets.all(10),
              height: emojis ? 150 : 0,
              duration: Duration(milliseconds: 250),
              child: Text('Here are the emojis'),
            ),
          ),
        ],
      ),
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
          iconTheme: IconThemeData(color: Colors.black //change your color here
              ),
          title: Text(
            'Messages',
            style:
                AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w400),
          ),
        ),
        body: SingleChildScrollView(
          child: ModalProgressHUD(
            inAsyncCall: Global.isLoading,
            color: AppColors.primaryColor,
            child: GestureDetector(
                onTap: () =>
                    FocusScope.of(context).requestFocus(new FocusNode()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: Stack(children: [
                      Container(
                        height: SizeConfig.safeBlockVertical * 94,
                        padding: EdgeInsets.fromLTRB(
                            16, isVisible ? 40 : 15, 16, 90),
                        child: ListView(
                            controller: _controller,
                            shrinkWrap: true,
                            children: chatMessages()),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: AnimatedSize(
                          vsync: this,
                          duration: Duration(milliseconds: 300),
                          child: Container(
                            height: isVisible ? 51.0 : 0.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        color: AppColors.compteDivider))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 15.0,
                                  ),
                                  child: Text(
                                    "Nom de l'entreprise",
                                    style: AppStyles.blackTextStyle
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: builMessageTextField())
                    ])),
                  ],
                )),
          ),
        ));
  }
}
