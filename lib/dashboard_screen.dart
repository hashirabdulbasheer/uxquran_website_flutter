import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_grid/responsive_grid.dart';

import 'app_options.dart';
import 'feedback_screen.dart';
import 'models/uxapps_model.dart';
import 'utils/color_utils.dart';
import 'utils/misc_utils.dart';
import 'views/ux_action_bar_button.dart';

class UxDashboardScreen extends StatelessWidget {
  const UxDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: screenBackground,
        appBar: AppBar(
          title: Image.asset("assets/images/Icon-512.png", height: 60),
          elevation: 0,
          actions: <Widget>[
            UXActionBarButton(
              title: "Blog",
              onPressed: () {
                QRUtils.launchURL(blogUrl);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: UXActionBarButton(
                title: "Contact us",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UxFeedbackScreen()));
                },
              ),
            )
          ],
        ),
        body: _displayContent());
  }

  _displayContent() {
    return FutureBuilder<List<UxApps>>(
      future: _readContent(), // async work
      builder: (BuildContext context, AsyncSnapshot<List<UxApps>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else {
              List<UxApps> appList = snapshot.data as List<UxApps>;
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: ResponsiveGridList(
                    desiredItemWidth: 300,
                    minSpacing: 10,
                    children: appList.map((app) {
                      return GestureDetector(
                        onTap: () {
                          QRUtils.launchURL(app.link);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //////////////////////////////////////////////
                                // HEADER
                                Row(
                                  children: <Widget>[
                                    Container(
                                        width: 40,
                                        child: Image.asset(
                                            "assets/images/${app.icon}",
                                            fit: BoxFit.cover),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 3.0,
                                              color: Colors.black12),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        )),
                                    SizedBox(width: 10),
                                    Text(
                                      "${app.title}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black87),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "${app.shortDescription}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontSize: 15,
                                      color: Colors.black45),
                                ),
                                //////////////////////////////////////////////

                                SizedBox(height: 20),
                                Container(
                                  height: 200,
                                  child: Center(
                                      child: Image.asset(
                                          "assets/images/${app.screenshot}",
                                          fit: BoxFit.scaleDown)),
                                ),
                                SizedBox(height: 10),

                                ////////////////////////////////////////////////
                                // Description
                                Text("Features:",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54)),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    height: 130,
                                    child: Text("${app.longDescription}",
                                        style: TextStyle(
                                            height: 1.5,
                                            fontSize: 15,
                                            color: Colors.black54)),
                                  ),
                                ),
                                ////////////////////////////////////////////////

                                SizedBox(height: 10),
                                Center(
                                    child: SizedBox(
                                  width: 200,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: orangeColor),
                                    child: Text(
                                      "Launch",
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                    onPressed: () {
                                      QRUtils.launchURL(app.link);
                                    },
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList()),
              );
            }
        }
      },
    );
  }

  Future<List<UxApps>> _readContent() async {
    String jsonString = await rootBundle.loadString('assets/input.json');
    return uxAppsFromJson(jsonString);
  }
}
