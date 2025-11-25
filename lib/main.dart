import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) WebView.platform = AndroidWebView();
  runApp(MahaBhulekhApp());
}

class MahaBhulekhApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mahabhulekh - 7/12 & 8A',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String baseUrl = 'https://bhulekh.mahabhumi.gov.in/';

  void openWebview(BuildContext context, String servicePath) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => WebviewPage(
        title: servicePath,
        initialUrl: baseUrl,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mahabhulekh'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => showAbout(context),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              LogoCard(),
              SizedBox(height: 18),
              Text(
                'Quick Services',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              ServiceTile(
                title: '७/१२ (7/12) Extract',
                subtitle: 'Search and download 7/12 extract (Jamabandi)',
                icon: Icons.description,
                onTap: () => openWebview(context, '7/12'),
              ),
              ServiceTile(
                title: '८अ (8A) Extract',
                subtitle: 'Search and download 8A record',
                icon: Icons.file_download,
                onTap: () => openWebview(context, '8A'),
              ),
              Spacer(),
              Text(
                'Note: This is a WebView wrapper for official Mahabhulekh site. No APIs used.',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('About'),
        content: Text('Mahabhulekh WebView app template. Select a service to open official site inside the app.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Close'))
        ],
      ),
    );
  }
}

class LogoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/logo.png', width: 72, height: 72),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mahabhulekh', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text('Official land records access - WebView', style: TextStyle(color: Colors.grey[700])),
                ],
              ),
            ),
            Icon(Icons.keyboard_arrow_right, size: 28),
          ],
        ),
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  ServiceTile({required this.title, required this.subtitle, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical:8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon), backgroundColor: Colors.indigo[50]),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.open_in_new),
        onTap: onTap,
      ),
    );
  }
}

class WebviewPage extends StatefulWidget {
  final String title;
  final String initialUrl;
  WebviewPage({required this.title, required this.initialUrl});

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) { setState(() => isLoading = false); },
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  Future<void> _openInBrowser() async {
    final url = await _controller.currentUrl();
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _shareUrl() async {
    final url = await _controller.currentUrl();
    if (url != null) await Share.share('Mahabhulekh link: $url');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(icon: Icon(Icons.open_in_browser), onPressed: _openInBrowser),
          IconButton(icon: Icon(Icons.share), onPressed: _shareUrl),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
