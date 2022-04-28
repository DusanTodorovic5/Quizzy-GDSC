import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkTile extends StatelessWidget {
  const LinkTile(
      {Key? key, required this.text, required this.link, required this.icon})
      : super(key: key);
  final String text;
  final String link;
  final IconData icon;
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(icon),
          Text(text),
        ],
      ),
      onTap: () => _launchURL(link),
    );
  }
}
