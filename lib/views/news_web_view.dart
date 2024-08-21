import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsWebView extends StatefulWidget {
  final String url;

  const NewsWebView({Key? key, required this.url}) : super(key: key);

  @override
  State<NewsWebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("News"),
      ),
      body: WebviewScaffold(
        url: widget.url,

        withZoom: true,
        withLocalStorage: true,
        withJavascript: true,
        hidden: true,
        initialChild: Center(child: CircularProgressIndicator()), // Display while loading
      ),
    );
  }
}
