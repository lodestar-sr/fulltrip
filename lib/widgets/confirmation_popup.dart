import 'package:Fulltrip/util/theme.dart';
import 'package:Fulltrip/widgets/action_buttons/accept_button.dart';
import 'package:Fulltrip/widgets/action_buttons/reject_button.dart';
import 'package:flutter/material.dart';

class ConfirmationPopup extends StatelessWidget {
  final String confirmationText;
  final String confirmationHint;
  final String acceptButtonText;
  final String rejectButtonText;
  final Function onAcceptButtonPressed;
  final Function onRejectButtonPressed;

  ConfirmationPopup({
    this.confirmationText,
    this.confirmationHint,
    this.acceptButtonText,
    this.rejectButtonText,
    this.onAcceptButtonPressed,
    this.onRejectButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          color: Color(0xFF757575),
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 25, 20, 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 25),
                  child: Text(
                    confirmationText,
                    textAlign: TextAlign.center,
                    style: AppStyles.confirmationTextStyle,
                  ),
                ),
                confirmationHint != null
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
                        child: Text(
                          confirmationHint,
                          textAlign: TextAlign.center,
                          style: AppStyles.confirmationHintStyle,
                        ),
                      )
                    : SizedBox(),
                AcceptButton(
                  text: acceptButtonText,
                  onPressed: onAcceptButtonPressed,
                ),
                RejectButton(
                  text: rejectButtonText,
                  onPressed: onRejectButtonPressed,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
