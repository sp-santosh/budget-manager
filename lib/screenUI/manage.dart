import 'package:budget_manager/main.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(Yellow());
}

class Yellow extends StatelessWidget {
  const Yellow({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage')),
      body: Container(child: Text('Hello')),
    );
  }
}
