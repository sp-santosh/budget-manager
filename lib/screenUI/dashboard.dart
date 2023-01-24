import 'package:budget_manager/main.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(Dashboard());
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Card(
              child: Text("Hello There"),
            ),
          )
        ],
      ),
    );
  }
}
