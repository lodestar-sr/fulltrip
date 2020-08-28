import 'package:Fulltrip/screens/search/carte.dart';
import 'package:Fulltrip/screens/search/liste.dart';
import 'package:Fulltrip/util/global.dart';
import 'package:Fulltrip/util/size_config.dart';
import 'package:Fulltrip/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  int _tabIndex = 0;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    setUpTabs();
  }

  setUpTabs() {
    setState(() {
      _tabIndex = Global.initialindex;
      print(Global.initialindex);
    });
    _controller = PageController(
      initialPage: _tabIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightestGreyColor,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        automaticallyImplyLeading: Global.searchTitle == 'Search for a lot' ? false : true,
        title: Text(
          Global.searchTitle,
          style: AppStyles.blackTextStyle.copyWith(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        centerTitle: true,
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
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 10),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _tabIndex = 0;
                                  _controller.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _tabIndex == 0 ? AppColors.primaryColor : Colors.transparent,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'Liste',
                                      style: AppStyles.blackTextStyle.copyWith(color: _tabIndex == 0 ? Colors.white : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _tabIndex = 1;
                                  _controller.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: _tabIndex == 1 ? AppColors.primaryColor : Colors.transparent,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'Carte',
                                      style: AppStyles.blackTextStyle.copyWith(color: _tabIndex == 1 ? Colors.white : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: SizeConfig.safeBlockVertical * 79,
                      child: Stack(
                        children: [
                          PageView(
                            physics: new NeverScrollableScrollPhysics(),
                            controller: _controller,
                            onPageChanged: (index) {
                              setState(() {
                                _tabIndex = index;
                              });
                            },
                            children: [
                              Liste(),
                              Carte(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
