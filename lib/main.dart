import 'package:beefit/constants/app_style.dart';
import 'package:beefit/widgets/ButtonMain.dart';
import 'package:beefit/widgets/ButtonTag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';

void main() {
  runApp(const MyRuler());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeeFit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ButtonMain(
                onPressed: () {},
                backgroundColor: AppStyle.primaryColor,
                text: "Next",
                textColor: AppStyle.whiteColor,
              ),
              ButtonTag(
                onPressed: () {},
                backgroundColor: AppStyle.primaryColor,
                text: "Next",
                textColor: AppStyle.whiteColor,
              ),
              RulerPicker(
                beginValue: 30,
                endValue: 200,
                initValue: 50,
                onValueChange: (value){
                },
                width: 320,
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class MyRuler extends StatelessWidget {
  const MyRuler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ruler Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Ruler Picker Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RulerPickerController? _rulerPickerController;

  int currentValue = 50;

  @override
  void initState() {
    super.initState();
    _rulerPickerController = RulerPickerController(value: 0);
  }

  Widget _buildBtn(int value) {
    return InkWell(
      onTap: () {
        _rulerPickerController?.value = value;
      },
      child: Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          color: Colors.blue,
          child: Text(
            value.toString(),
            style: const TextStyle(color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  currentValue.toString(),
                  style: const TextStyle(
                      color: AppStyle.primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 30),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text("kg",style: TextStyle(color: AppStyle.black1Color, fontSize: 18),),
                )
              ],
            ),
            SizedBox(height: 20),
            RulerPicker(
              controller: _rulerPickerController!,
              beginValue: 30,
              endValue: 100,
              initValue: currentValue,
              rulerScaleTextStyle: TextStyle(
                color: AppStyle.black1Color
              ),
              scaleLineStyleList: [
                ScaleLineStyle(
                    color: Colors.grey, width: 1.5, height: 30, scale: 0),
                ScaleLineStyle(
                    color: Colors.grey, width: 1, height: 25, scale: 5),
                ScaleLineStyle(
                    color: Colors.grey, width: 1, height: 15, scale: -1)
              ],
              // onBuildRulerScalueText: (index, scaleValue) {
              //   return scaleValue.toString();
              // },
              onValueChange: (value) {
                setState(() {
                  currentValue = value;
                });
              },
              width: MediaQuery.of(context).size.width,
              height: 80,
              rulerMarginTop: 30,
              marker: Container(
                  width: 4,
                  height: 140,
                  decoration: BoxDecoration(
                      color: AppStyle.primaryColor,
                      borderRadius: BorderRadius.circular(5))),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBtn(30),
                SizedBox(width: 10),
                _buildBtn(50),
                SizedBox(width: 10),
                _buildBtn(70),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
