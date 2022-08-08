import 'package:flutter/material.dart';

import 'utils/color_utils.dart';
import 'utils/network_utils.dart';
import 'utils/misc_utils.dart';

class UxFeedbackScreen extends StatefulWidget {
  @override
  _UxFeedbackScreenState createState() => _UxFeedbackScreenState();
}

class _UxFeedbackScreenState extends State<UxFeedbackScreen> {
  TextEditingController _editingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: screenBackground,
        appBar: AppBar(title: Text("Feedback"), elevation: 0),
        body: _displayFeedbackForm());
  }

  _displayFeedbackForm() {
    return GestureDetector(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30),
                  Image.asset("assets/images/Icon-512.png", height: 100),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                    child: Text(
                        "Building technologies to enhance our relationship with the Noble Quran",
                        style: TextStyle(color: Colors.black54, height: 1.5)),
                  ),
                  TextButton(
                    child: Text("support@uxquran.com",
                        style:
                            TextStyle(fontSize: 25, color: Colors.blueAccent)),
                    onPressed: () {
                      QRUtils.launchURL("mailto:support@uxquran.com");
                    },
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
                    child: Theme(
                      data: new ThemeData(
                        primaryColor: Colors.redAccent,
                        primaryColorDark: Colors.red,
                      ),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        controller: _editingController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.black)),
                            hintText: 'Enter your feedback here'),
                        maxLines: 5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 30, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: orangeColor),
                          child: Text(
                            "Send",
                            style: TextStyle(color: Colors.black87),
                          ),
                          onPressed: () {
                            String message = "";
                            message = message + "\n${_editingController.text}";
                            QRServerCommunications.postToSlack(message)
                                .then((result) {
                              if (result) {
                                _editingController.text = "";
                                QRUtils.showSnackbar(context,
                                    "Thanks, Your message has been sent.");
                              } else {
                                QRUtils.showSnackbar(context,
                                    "Sorry, we are not able to send your message. Please try again later.");
                              }
                            });
                          },
                        ),
                        Text("uxquran.com")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        });
  }
}
