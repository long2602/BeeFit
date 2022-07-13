import 'package:beefit/constants/AppStyles.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/AppMethods.dart';
import '../controls/ApiService.dart';
import '../models/nutrition/Ingredient.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DetailFoodScreen extends StatefulWidget {
  final Ingredient _ingredient;
  const DetailFoodScreen({required Ingredient ingredient, Key? key})
      : _ingredient = ingredient,
        super(key: key);

  @override
  _DetailFoodScreenState createState() => _DetailFoodScreenState();
}

class _DetailFoodScreenState extends State<DetailFoodScreen> {
  late final Ingredient _ingredient = widget._ingredient;
  late Nutrient _nuProtein, _nuFat, _nuCarb, _nuCalo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNutrient(_ingredient.nutrition!.Nutrients);
  }

  getNutrient(List<Nutrient> nutrients) {
    _nuCalo =
        nutrients.where((element) => element.name == 'Calories') as Nutrient;
    _nuCarb = nutrients.where((element) => element.name == 'Carbohydrates')
        as Nutrient;
    _nuFat = nutrients.where((element) => element.name == 'Fat') as Nutrient;
    _nuProtein =
        nutrients.where((element) => element.name == 'Protein') as Nutrient;
  }

  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
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
              onPressed: () {},
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
              onPressed: () {},
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              _ingredient.image,
              width: double.infinity,
              // height: 200,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _ingredient.name.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: AppStyle.secondaryColor,
                      fontSize: 24 * _scaleFont,
                    ),
                  ),
                  Divider(),
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
                                    _ingredient.nutrition!.caloricBreakdown),
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
                                donutWidth: 10,
                                animate: true,
                                pieLabel:
                                    (Map<dynamic, dynamic> pie, int? index) {
                                  return "";
                                },
                              ),
                              Center(
                                child: Text(
                                  _nuCalo.amount.toString(),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: AppStyle.secondaryColor,
                                    fontSize: 24 * _scaleFont,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  _ingredient.nutrition!.caloricBreakdown
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
                                  _ingredient.nutrition!.caloricBreakdown
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
                                  _ingredient.nutrition!.caloricBreakdown
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
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
      // body: SingleChildScrollView(
      //   child: FutureBuilder(
      //     future: ApiService.instance
      //         .fetchIngredient(widget._ingredient.id.toString()),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           return const Center(
      //             child: CircularProgressIndicator(),
      //           );
      //         } else {
      //           _ingredient = snapshot.data as Ingredient?;
      //           return Column(
      //             children: [
      //               Image.network(_ingredient!.image),
      //             ],
      //           );
      //         }
      //       } else if (snapshot.hasError) {
      //         return const Text('no data');
      //       }
      //       return Center(child: const CircularProgressIndicator());
      //     },
      //   ),
      // ),
    );
  }
}
