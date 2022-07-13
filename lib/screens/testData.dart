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

Map<String, dynamic> testMap = {
  "id": 9266,
  "original": "pineapples",
  "originalName": "pineapples",
  "name": "pineapples",
  "amount": 1.0,
  "unit": "",
  "unitShort": "",
  "unitLong": "",
  "possibleUnits": ["piece", "slice", "fruit", "g", "oz", "cup", "serving"],
  "estimatedCost": {"value": 299.0, "unit": "US Cents"},
  "consistency": "solid",
  "shoppingListUnits": ["pieces"],
  "aisle": "Produce",
  "image": "pineapple.jpg",
  "meta": [],
  "nutrition": {
    "nutrients": [
      {
        "name": "Calories",
        "amount": 452.5,
        "unit": "cal",
        "percentOfDailyNeeds": 22.63
      },
      {"name": "Fat", "amount": 1.09, "unit": "g", "percentOfDailyNeeds": 1.67},
      {
        "name": "Saturated Fat",
        "amount": 0.08,
        "unit": "g",
        "percentOfDailyNeeds": 0.51
      },
      {
        "name": "Carbohydrates",
        "amount": 118.74,
        "unit": "g",
        "percentOfDailyNeeds": 39.58
      },
      {
        "name": "Net Carbohydrates",
        "amount": 106.07,
        "unit": "g",
        "percentOfDailyNeeds": 38.57
      },
      {
        "name": "Sugar",
        "amount": 89.14,
        "unit": "g",
        "percentOfDailyNeeds": 99.05
      },
      {
        "name": "Cholesterol",
        "amount": 0.0,
        "unit": "mg",
        "percentOfDailyNeeds": 0.0
      },
      {
        "name": "Sodium",
        "amount": 9.05,
        "unit": "mg",
        "percentOfDailyNeeds": 0.39
      },
      {
        "name": "Protein",
        "amount": 4.89,
        "unit": "g",
        "percentOfDailyNeeds": 9.77
      },
      {
        "name": "Vitamin C",
        "amount": 432.59,
        "unit": "mg",
        "percentOfDailyNeeds": 524.35
      },
      {
        "name": "Manganese",
        "amount": 8.39,
        "unit": "mg",
        "percentOfDailyNeeds": 419.47
      },
      {
        "name": "Fiber",
        "amount": 12.67,
        "unit": "g",
        "percentOfDailyNeeds": 50.68
      },
      {
        "name": "Vitamin B6",
        "amount": 1.01,
        "unit": "mg",
        "percentOfDailyNeeds": 50.68
      },
      {
        "name": "Copper",
        "amount": 1.0,
        "unit": "mg",
        "percentOfDailyNeeds": 49.78
      },
      {
        "name": "Vitamin B1",
        "amount": 0.72,
        "unit": "mg",
        "percentOfDailyNeeds": 47.66
      },
      {
        "name": "Folate",
        "amount": 162.9,
        "unit": "µg",
        "percentOfDailyNeeds": 40.73
      },
      {
        "name": "Potassium",
        "amount": 986.45,
        "unit": "mg",
        "percentOfDailyNeeds": 28.18
      },
      {
        "name": "Magnesium",
        "amount": 108.6,
        "unit": "mg",
        "percentOfDailyNeeds": 27.15
      },
      {
        "name": "Vitamin B3",
        "amount": 4.53,
        "unit": "mg",
        "percentOfDailyNeeds": 22.63
      },
      {
        "name": "Vitamin B5",
        "amount": 1.93,
        "unit": "mg",
        "percentOfDailyNeeds": 19.28
      },
      {
        "name": "Vitamin B2",
        "amount": 0.29,
        "unit": "mg",
        "percentOfDailyNeeds": 17.04
      },
      {
        "name": "Iron",
        "amount": 2.62,
        "unit": "mg",
        "percentOfDailyNeeds": 14.58
      },
      {
        "name": "Calcium",
        "amount": 117.65,
        "unit": "mg",
        "percentOfDailyNeeds": 11.77
      },
      {
        "name": "Vitamin A",
        "amount": 524.9,
        "unit": "IU",
        "percentOfDailyNeeds": 10.5
      },
      {
        "name": "Zinc",
        "amount": 1.09,
        "unit": "mg",
        "percentOfDailyNeeds": 7.24
      },
      {
        "name": "Phosphorus",
        "amount": 72.4,
        "unit": "mg",
        "percentOfDailyNeeds": 7.24
      },
      {
        "name": "Vitamin K",
        "amount": 6.34,
        "unit": "Âµg",
        "percentOfDailyNeeds": 6.03
      },
      {
        "name": "Selenium",
        "amount": 0.91,
        "unit": "Âµg",
        "percentOfDailyNeeds": 1.29
      },
      {
        "name": "Vitamin E",
        "amount": 0.18,
        "unit": "mg",
        "percentOfDailyNeeds": 1.21
      }
    ],
    "properties": [
      {"name": "Glycemic Index", "amount": 58.67, "unit": ""},
      {"name": "Glycemic Load", "amount": 62.23, "unit": ""}
    ],
    "flavonoids": [
      {"name": "Cyanidin", "amount": 0.0, "unit": "mg"}
    ],
    "caloricBreakdown": {
      "percentProtein": 3.88,
      "percentFat": 1.94,
      "percentCarbs": 94.18
    },
    "weightPerServing": {"amount": 905, "unit": "g"}
  },
  "categoryPath": ["tropical fruit", "fruit"]
};

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
