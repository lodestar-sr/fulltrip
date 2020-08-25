import 'package:flutter/material.dart';

class DescriptionText extends StatefulWidget {
  final text;
  final minLength;
  final textStyle;
  final moreTextStyle;

  DescriptionText({
    @required this.text,
    this.minLength,
    this.textStyle,
    this.moreTextStyle,
  });

  @override
  _DescriptionTextState createState() => new _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > widget.minLength) {
      firstHalf = widget.text.substring(0, widget.minLength);
      secondHalf = widget.text.substring(widget.minLength, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  style: widget.textStyle,
                ),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        flag ? "More" : "Less",
                        style: widget.moreTextStyle,
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
