import 'package:flutter/material.dart';

class UXActionBarButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  UXActionBarButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text(this.title, style: _getActionBarTextStyle()),
        onPressed: this.onPressed);
  }

  _getActionBarTextStyle() {
    return TextStyle(
        fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w400);
  }
}
