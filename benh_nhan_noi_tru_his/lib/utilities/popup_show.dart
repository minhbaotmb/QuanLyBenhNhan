import 'package:flutter/material.dart';

import '../commons.dart';

class PopupShow {
  static BuildContext? contextPopup;

  static Future<bool> showMesseageDialog(
    BuildContext context, {
    bool? showDeleteCircle,
    bool? showLogo,
    bool? showTitleSoftware,
    String? text1,
    Color? colorText1,
    String? text2,
    Color? colorText2,
    Widget? bodyWidget,
    List<Widget>? buttonWidgets,
    bool hideButtonClose = false,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            content: Stack(
              children: <Widget>[
                // show delete circle
                if (showDeleteCircle != null && showDeleteCircle)
                  Positioned(
                    right: -10.0,
                    top: -10.0,
                    child: InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.close,
                          color: Commons.kColor,
                        ),
                      ),
                    ),
                  ),
                Form(
                  //key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // show logo
                      // if (showLogo != null && showLogo)
                      //   Padding(
                      //       padding: EdgeInsets.all(1.0),
                      //       child: Image.asset(Constants.logoLQL,
                      //           width: 60, fit: BoxFit.contain)),

                      // show title software
                      if (showTitleSoftware != null && showTitleSoftware)
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text('BVĐK Long Khánh',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      // show title software
                      if (showTitleSoftware != null && showTitleSoftware)
                        const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 15),
                          child: Text('Thông tin bệnh nhân',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Commons.kColor,
                                  fontWeight: FontWeight.bold)),
                        ),

                      // show text1,
                      if (text1 != null && text1.isNotEmpty)
                        const SizedBox(height: 30),
                      if (text1 != null && text1.isNotEmpty)
                        Text(text1,
                            style: TextStyle(
                                color: colorText1 ?? Colors.black,
                                fontWeight: FontWeight.bold)),

                      //show text2
                      if (text2 != null && text2.isNotEmpty)
                        const SizedBox(height: 5),
                      if (text2 != null && text2.isNotEmpty)
                        Text(text2,
                            style: TextStyle(
                              color: colorText2 ?? Colors.black,
                            )),

                      // show body
                      if (bodyWidget != null) bodyWidget,

                      const SizedBox(height: 10),

                      // active button

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (buttonWidgets != null)
                            Column(children: buttonWidgets),
                          if (buttonWidgets != null &&
                              buttonWidgets.length == 1)
                            const SizedBox(width: 20),
                          if (!hideButtonClose)
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                //return;
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: const Text('Đóng'),
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });

    return false;
  }

  static void showMessage(
    BuildContext context,
    String title,
    String message,
    String buttonText,
    Function onPressed, {
    bool isConfirmationDialog = false,
    String buttonText2 = "",
    required Function() onPressed2,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () => onPressed,
              child: Text(buttonText),
            ),
            Visibility(
              visible: isConfirmationDialog,
              child: TextButton(
                onPressed: onPressed2,
                child: Text(buttonText2),
              ),
            ),
          ],
        );
      },
    );
  }
}
