import "package:amanah/constants/app_theme.dart";
import "package:amanah/screens/Lenders/home/homepage_screen.dart";
import "package:flutter/material.dart";
import "package:webview_flutter/webview_flutter.dart";

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.url});
  final String url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  WebViewController? _controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(Uri.parse("https://${widget.url}"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Pembayaran',
            style: bodyTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (Route<dynamic> route) => false);
          },
        ),
        actions: [
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  if (await _controller!.canGoBack()) {
                    await _controller!.goBack();
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(content: Text('No back history item')),
                    );
                    return;
                  }
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  if (await _controller!.canGoForward()) {
                    await _controller!.goForward();
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(content: Text('No forward history item')),
                    );
                    return;
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.replay, color: Colors.black),
                onPressed: () {
                  _controller!.reload();
                },
              ),
            ],
          )
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller!),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}
