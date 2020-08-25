import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MessagesTab extends StatefulWidget {
  MessagesTab({Key key}) : super(key: key);

  @override
  _MessagesTabState createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {
  @override
  void initState() {
    super.initState();
    Global.isLoading = false;
  }

  List<Widget> getMessages() {
    List<Widget> list = [];
    Global.userMessages.forEach((element) {
      list.add(
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => Navigator.of(context).pushNamed('ChatMessages'),
          child: Container(
            padding: EdgeInsets.only(bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.chatIconColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            'W',
                            style: AppStyles.blackTextStyle.copyWith(
                              fontSize: 24,
                            ),
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
                              color: element.status == 'online'
                                  ? AppColors.darkgreenColor
                                  : Colors.orangeAccent,
                              border: Border.all(
                                color: AppColors.borderwhite,
                                width: 1.5,
                              ),
                              shape: BoxShape.circle),
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
                      SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            element.name,
                            style: AppStyles.blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '3:03pm',
                            style: AppStyles.greyTextStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              element.message,
                              style: AppStyles.greyTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              '${element.unread}',
                              style: TextStyle(color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.redColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });

    if (list.length == 0) {
      list.add(
        Container(
          padding: EdgeInsets.only(left: 32, right: 32, top: 48),
          child: Center(
            child: Text(
              'No data available',
              style: TextStyle(
                color: AppColors.greyColor,
                fontSize: 14,
                height: 1.8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      color: AppColors.primaryColor,
      progressIndicator: AppLoader(),
      child: Container(
        height: double.infinity,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: getMessages(),
        ),
      ),
    );
  }
}
