
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import Services

const String deepLinkChannel1 = 'deepLinkChannel';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String values = "Home Screen";
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Deep Link'),
        ),
        body: Center(
          child: Text(values),
        ),
      ),
    );
  }

  @override
  void initState() {
    final MethodChannel deepLinkChannel = MethodChannel(deepLinkChannel1);
    setupPlatformChannels(deepLinkChannel, context); // Pass the context here
    super.initState();
  }

  void handleDeepLink(BuildContext context, String value) {
    setState(() {
      values = value.toString();
    });
    print('Deep link received: $value');

    runApp(DetailsApp(value));
  }

  void setupPlatformChannels(MethodChannel channel, BuildContext context) {
    channel.setMethodCallHandler((call) async {
      if (call.method == 'receiveDeepLink') {
        handleDeepLink(context, call.arguments as String); // Pass the context here
      }
    });
  }
}

class DetailsApp extends StatelessWidget {

  final String value;

  DetailsApp(this.value);

  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deep Linking Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DetailsPage(value: value,),
    );
  }
}


class DetailsPage extends StatelessWidget {
  final String value;

  DetailsPage({required this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: Text('Details Screen : ' + value),
      ),
    );
  }
}
