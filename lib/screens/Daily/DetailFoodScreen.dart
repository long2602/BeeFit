import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/models/databaseHelper.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import '../../constants/AppMethods.dart';
import '../../controls/ApiService.dart';
import '../../models/nutrition/Ingredient.dart';
import '../../widgets/ButtonMain.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class DetailFoodScreen extends StatefulWidget {
  final int _meal;
  final Ingredient _ingredient;

  DetailFoodScreen(
      {required Ingredient ingredient, required int meal, Key? key})
      : _ingredient = ingredient,
        _meal = meal,
        super(key: key);

  @override
  _DetailFoodScreenState createState() => _DetailFoodScreenState();
}

class _DetailFoodScreenState extends State<DetailFoodScreen> {
  late Ingredient _ingredient;
  late Map<String, dynamic> _mapIngredient;
  late Nutrient _nuProtein, _nuFat, _nuCarb, _nuCalo;
  bool isShow = true;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  insertData() async {
    databaseHelper.database;
    String food = json.encode(_mapIngredient);
    Map<String, dynamic> row = {
      'fday': DateFormat("yyyy-MM-dd").format(DateTime.now()),
      'ftime': DateFormat("HH:mm:ss").format(DateTime.now()),
      'meal': widget._meal,
      'ingredient': food,
      'id_planDetail': 1,
    };
    try {
      await databaseHelper.insert('food_history', row).then((id) {
        print('insert row id: $id');
      });
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {}
    }
  }

  getNutrient(List<Nutrient> nutrients) {
    _nuCalo = nutrients.firstWhere((element) => element.name == 'Calories');
    _nuCarb =
        nutrients.firstWhere((element) => element.name == 'Carbohydrates');
    _nuFat = nutrients.firstWhere((element) => element.name == 'Fat');
    _nuProtein = nutrients.firstWhere((element) => element.name == 'Protein');
  }

  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    final _scaleScreen = AppMethods.screenScale(context);

    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyle.whiteColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 24 * _scaleScreen,
                color: AppStyle.secondaryColor,
              ),
            ),
            Expanded(
              child: Text(
                'Add Food',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: AppStyle.secondaryColor,
                  fontSize: 24 * _scaleFont,
                ),
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // Navigator.pop(
                //   context,
                //   _ingredient,
                // );
                insertData();

                int count = 0;
                Navigator.popUntil(
                  context,
                  (route) {
                    return count++ == 2;
                  },
                );
              },
              icon: Icon(
                Icons.check,
                size: 24 * _scaleScreen,
                color: AppStyle.secondaryColor,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: ApiService.instance
                  .fetchMapIngredient(widget._ingredient.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    _mapIngredient = snapshot.data as Map<String, dynamic>;
                    _ingredient = Ingredient.fromMap(_mapIngredient);
                    getNutrient(_ingredient.nutrition!.Nutrients);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10 * _scaleScreen),
                          child: Image.network(
                            _ingredient.image!,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30 * _scaleScreen),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _ingredient.name!.toUpperCase(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: AppStyle.secondaryColor,
                                  fontSize: 24 * _scaleFont,
                                ),
                              ),
                              const Divider(thickness: 1),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Stack(
                                        children: [
                                          DChartPie(
                                            data: CaloricBreakdown.convertToMap(
                                                _ingredient.nutrition!
                                                    .caloricBreakdown),
                                            fillColor: (pieData, index) {
                                              switch (pieData['domain']) {
                                                case 'Protein':
                                                  return AppStyle.primaryColor;
                                                case 'Fat':
                                                  return AppStyle.errorColor;
                                                case 'Carbs':
                                                  return AppStyle.successColor;
                                              }
                                            },
                                            labelLinelength: 16,
                                            labelLineThickness: 2,
                                            showLabelLine: false,
                                            strokeWidth: 2,
                                            donutWidth: 5,
                                            animate: true,
                                            pieLabel:
                                                (Map<dynamic, dynamic> pie,
                                                    int? index) {
                                              return "";
                                            },
                                          ),
                                          Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  _nuCalo.amount.toString(),
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppStyle.secondaryColor,
                                                    fontSize: 16 * _scaleFont,
                                                  ),
                                                ),
                                                Text(
                                                  "cal",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppStyle.gray3Color,
                                                    fontSize: 12 * _scaleFont,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              _ingredient
                                                      .nutrition!
                                                      .caloricBreakdown
                                                      .percentCarbs
                                                      .toString() +
                                                  "%",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                color: AppStyle.secondaryColor,
                                                fontSize: 12 * _scaleFont,
                                              ),
                                            ),
                                            Text(
                                              _nuCarb.amount.toString(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                color: AppStyle.secondaryColor,
                                                fontSize: 18 * _scaleFont,
                                              ),
                                            ),
                                            Text(
                                              'Carbs',
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                color: AppStyle.secondaryColor,
                                                fontSize: 14 * _scaleFont,
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              _ingredient
                                                      .nutrition!
                                                      .caloricBreakdown
                                                      .percentFat
                                                      .toString() +
                                                  "%",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                color: AppStyle.secondaryColor,
                                                fontSize: 12 * _scaleFont,
                                              ),
                                            ),
                                            Text(
                                              _nuFat.amount.toString(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                color: AppStyle.secondaryColor,
                                                fontSize: 18 * _scaleFont,
                                              ),
                                            ),
                                            Text(
                                              'Fat',
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                color: AppStyle.secondaryColor,
                                                fontSize: 14 * _scaleFont,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              _ingredient
                                                      .nutrition!
                                                      .caloricBreakdown
                                                      .percentProtein
                                                      .toString() +
                                                  "%",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                color: AppStyle.secondaryColor,
                                                fontSize: 12 * _scaleFont,
                                              ),
                                            ),
                                            Text(
                                              _nuProtein.amount.toString(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                color: AppStyle.secondaryColor,
                                                fontSize: 18 * _scaleFont,
                                              ),
                                            ),
                                            Text(
                                              'Protein',
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                color: AppStyle.secondaryColor,
                                                fontSize: 14 * _scaleFont,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 1),
                              ListTile(
                                title: Text(
                                  'Serving Size',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: AppStyle.black1Color,
                                    fontSize: 14 * _scaleFont,
                                  ),
                                ),
                                trailing: Text(
                                  _ingredient.amount.toString(),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: AppStyle.secondaryColor,
                                    fontSize: 16 * _scaleFont,
                                  ),
                                ),
                                onTap: () => showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    builder: (context) =>
                                        buildSheet(_ingredient.possibleUnits!)),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 16 * _scaleScreen),
                                child: ButtonMain(
                                  onPressed: () {
                                    setState(() {
                                      isShow ? isShow = false : isShow = true;
                                    });
                                  },
                                  backgroundColor: AppStyle.gray5Color,
                                  text: !isShow
                                      ? 'Show Nutrition Facts'
                                      : 'Hide Nutrition Facts',
                                  textColor: AppStyle.gray2Color,
                                  height: 40 * _scaleScreen,
                                ),
                              ),
                              Visibility(
                                visible: isShow,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount:
                                      _ingredient.nutrition!.Nutrients.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(thickness: 0.5),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Nutrient nutrient =
                                        _ingredient.nutrition!.Nutrients[index];
                                    return ListTile(
                                      title: Text(
                                        nutrient.name,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          color: AppStyle.black1Color,
                                          fontSize: 14 * _scaleFont,
                                        ),
                                      ),
                                      trailing: Text(
                                        "${nutrient.amount.toString()} ${nutrient.unit}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: AppStyle.secondaryColor,
                                          fontSize: 14 * _scaleFont,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                } else if (snapshot.hasError) {
                  return const Text('no data');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSheet(List<String> units) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(units[index], style: GoogleFonts.poppins()),
          onTap: () {},
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(thickness: 0.5),
      itemCount: units.length,
    );
  }
}
