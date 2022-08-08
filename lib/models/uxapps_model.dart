// To parse this JSON data, do
//
//     final uxApps = uxAppsFromJson(jsonString);

import 'dart:convert';

List<UxApps> uxAppsFromJson(String str) =>
    List<UxApps>.from(json.decode(str).map((x) => UxApps.fromJson(x)));

String uxAppsToJson(List<UxApps> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UxApps {
  String title;
  String shortDescription;
  String longDescription;
  String screenshot;
  String icon;
  String link;
  String id;

  UxApps({
    required this.title,
    required this.shortDescription,
    required this.longDescription,
    required this.screenshot,
    required this.icon,
    required this.link,
    required this.id,
  });

  factory UxApps.fromJson(Map<String, dynamic> json) => UxApps(
        title: json["title"],
        shortDescription: json["short-description"],
        longDescription: json["long-description"],
        screenshot: json["screenshot"],
        icon: json["icon"] == null ? null : json["icon"],
        link: json["link"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "short-description": shortDescription,
        "long-description": longDescription,
        "screenshot": screenshot,
        "icon": icon,
        "link": link,
        "id": id,
      };
}
