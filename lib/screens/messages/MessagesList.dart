import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({Key key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  @override
  void initState() {
    super.initState();
    Global.isLoading = false;
  }

  List<Widget> getmessages() {
    List<Widget> list = [];
    Global.usermessages.forEach((element) {
      list.add(GestureDetector(
        onTap: () => Navigator.of(context).pushNamed('ChatMessages'),
        child: Container(
          padding: EdgeInsets.only(bottom: 15),
          child: Row(
            children: [
              Container(
                child: Stack(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(color: AppColors.chatIconColor, shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          'W',
                          style: AppStyles.blackTextStyle.copyWith(fontSize: 24),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                            color: element.status == 'online' ? AppColors.darkgreenColor : Colors.orangeAccent, border: Border.all(color: AppColors.borderwhite, width: 1.5), shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      element.name,
                      style: AppStyles.blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        element.message,
                        style: AppStyles.greyTextStyle.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '3:03pm',
                    style: AppStyles.greyTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        '${element.unread}',
                        style: TextStyle(color: Colors.white),
                      ),
                      decoration: BoxDecoration(color: AppColors.redColor, shape: BoxShape.circle),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ));
    });
    if (list.length == 0) {
      list.add(Container(
        padding: EdgeInsets.only(left: 32, right: 32, top: 48),
        child: Center(
          child: Text(
            'No data Available',
            style: TextStyle(color: AppColors.greyColor, fontSize: 14, height: 1.8),
            textAlign: TextAlign.center,
          ),
        ),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
        inAsyncCall: Global.isLoading,
        color: AppColors.primaryColor,
        progressIndicator: CircularProgressIndicator(),
        child: Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              title: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  'Messages',
                  style: AppStyles.blackTextStyle.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            body: LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                      child: GestureDetector(
                          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: viewportConstraints.maxHeight,
                              ),
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(16, 10, 16, 40),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                                    Container(
                                      height: SizeConfig.safeBlockHorizontal * 160,
                                      child: ListView(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(left: 4, right: 4, top: 10),
                                        children: getmessages(),
                                      ),
                                    )
                                  ]))))));
            })));
  }
}
