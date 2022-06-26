import 'package:flutter/material.dart';
import '../constants/AppStyles.dart';
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
      backgroundColor: AppStyle.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyle.whiteColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 52,vertical: 52),
            child: Text(
              "We are creating plans for you...",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: AppStyle.secondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          PercentIndicator(),
        ],
      ),
    );
  }
}
