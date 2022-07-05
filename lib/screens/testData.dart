import 'package:beefit/models/User.dart';
import 'package:beefit/models/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class TestData extends StatefulWidget {
  const TestData({Key? key}) : super(key: key);

  @override
  State<TestData> createState() => _TestDataState();
}

class _TestDataState extends State<TestData> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<User> lists = [];

  insertData() async {
    databaseHelper.database;
    Map<String, dynamic> row = {
      'Name': 'duy',
      'Gender': 0,
      'Age': 22,
      'Height': 170,
      'Weight': 70,
      'BodyStatus': 3,
      'IdTarget': 1,
    };
    try {
      await databaseHelper.insert('user', row).then((id) {
        print('insert row id: $id');
        setState(() {
          lists.add(User.map(row));
        });
      });
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {}
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseHelper.getAll('user').then((value) {
      setState(() {
        value.forEach((element) {
          lists.add(User.map(element));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('testdata'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: lists.length,
          itemBuilder: (context, index) {
            return Text(lists[index].name ?? "hello");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          insertData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


// // Container(
// // padding: EdgeInsets.symmetric(
// // horizontal: 15 * _scaleScreen, vertical: 15 * _scaleScreen),
// // decoration: BoxDecoration(
// // color: AppStyle.primaryColor,
// // borderRadius: AppStyle.appBorder,
// // ),
// // child: Column(
// // children: [
// // Row(
// // mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // children: [
// // Text(
// // "Weekly Active Days",
// // style: GoogleFonts.poppins(
// // fontWeight: FontWeight.bold,
// // color: AppStyle.whiteColor,
// // fontSize: 14 * _scaleFont,
// // ),
// // ),
// // Text(
// // "1/4",
// // style: GoogleFonts.poppins(
// // color: AppStyle.whiteColor,
// // fontSize: 14 * _scaleFont,
// // ),
// ),
// ],
// ),
// Container(
// padding: EdgeInsets.only(top: 10 * _scaleScreen),
// height: 40 * _scaleScreen,
// child: ListView.builder(
// scrollDirection: Axis.horizontal,
// itemCount: 30,
// itemBuilder: (context, index) {
// return Container(
// margin: EdgeInsets.only(right: index!=29? 8:0),
// height: 30 * _scaleScreen,
// width: 30 * _scaleScreen,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(100),
// color: AppStyle.whiteColor,
// ),
// child: Center(
// child: Text(
// (index + 1).toString(),
// style: GoogleFonts.poppins(
// color: AppStyle.primaryColor,
// fontSize: 14 * _scaleFont,
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
// );
// },
// ),
// ),
// ],
// ),
// ),
