import 'package:flutter/material.dart';

import '../widgets/PercentIndicator.dart';

class OnProgressScreen extends StatefulWidget {
  const OnProgressScreen({Key? key}) : super(key: key);

  @override
  State<OnProgressScreen> createState() => _OnProgressScreenState();
}

class _OnProgressScreenState extends State<OnProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("We are creating plans for you..."),
          PercentIndicator(),
        ],
      ),
    );
  }
}
