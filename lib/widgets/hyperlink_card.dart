import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HyperlinkCard extends StatelessWidget {
  final String title;
  final String url;
  final String subject;

  const HyperlinkCard({required this.title, required this.url, required this.subject});

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: InkWell(
          onTap: _launchURL,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Text("Subject: $subject"),
        trailing: Icon(Icons.open_in_new, size: 18),
      ),
    );
  }
}
