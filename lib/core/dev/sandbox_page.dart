import 'package:flutter/material.dart';

class SandboxPage extends StatelessWidget {
  const SandboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sandbox')),
      body: const SizedBox.expand(),
    );
  }
}
