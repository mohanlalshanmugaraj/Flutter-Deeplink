import 'package:flutter/material.dart';

class OtherScreen extends StatelessWidget {
  final String deepLinkValue;

  const OtherScreen({Key? key, required this.deepLinkValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deep Link Screen'),
      ),
      body: Center(
        child: Text(
          'Deep Link Value: $deepLinkValue',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
