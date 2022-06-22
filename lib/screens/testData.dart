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
