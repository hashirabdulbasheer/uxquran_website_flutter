import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../app_options.dart';

class QRServerCommunications {
  static Future<bool> postToSlack(String message) async {
    try {
      Map<String, String> slackHeader = {
        "Content-Type": "application/x-www-form-urlencoded"
      };

      String header = "OS: Web";

      Map<String, dynamic> requestParameter = new Map<String, dynamic>();
      requestParameter["text"] = "$header \n $message";

      var registerRequestJsonString = json.encode(requestParameter);
      final response = await http.Client()
          .post(Uri.parse(utf8.decode(base64.decode(feedbackUrl))),
              headers: slackHeader, body: registerRequestJsonString)
          .timeout(Duration(seconds: 5));
      if (response.statusCode == 200) {
        return true;
      }
    } on Exception catch (_) {}
    return false;
  }
}
