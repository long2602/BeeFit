import 'package:beefit/constants/AppMethods.dart';
import 'package:beefit/constants/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controls/ApiService.dart';
import '../models/nutrition/Ingredient.dart';
import 'DetailFoodScreen.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({Key? key}) : super(key: key);

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final TextEditingController _searchController = TextEditingController();
  ResultIngredients? _resultIngredients;
  String _keyword = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppStyle.gray5Color.withOpacity(0.25),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppStyle.primaryColor,
          title: Text(
            'Add Breakfast',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: AppStyle.whiteColor,
              fontSize: 24 * _scaleFont,
            ),
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(85),
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 30 * _scaleScreen, vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: AppStyle.primaryColor2),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _keyword = value;
                  });
                },
                style: GoogleFonts.poppins(
                    color: AppStyle.whiteColor, fontWeight: FontWeight.w500),
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: AppStyle.whiteColor,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Search for food',
                  hintStyle: TextStyle(
                      color: AppStyle.whiteColor, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'My food'),
              ],
              labelStyle: GoogleFonts.poppins(
                fontSize: 14 * _scaleFont,
                fontWeight: FontWeight.w700,
              ),
              labelColor: AppStyle.secondaryColor,
              unselectedLabelColor: AppStyle.gray4Color,
              indicatorColor: AppStyle.primaryColor,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: FutureBuilder(
                      future: ApiService.instance.searchIngredient(_keyword),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            _resultIngredients =
                                snapshot.data as ResultIngredients;
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30 * _scaleScreen,
                              ),
                              child: ListView.builder(
                                itemCount:
                                    _resultIngredients!.ingredients.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => DetailFoodScreen(
                                                ingredient: _resultIngredients!
                                                    .ingredients[index])),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 6 * _scaleScreen),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16 * _scaleScreen,
                                          vertical: 12 * _scaleScreen),
                                      decoration: BoxDecoration(
                                        color: AppStyle.whiteColor,
                                        borderRadius: AppStyle.appBorder,
                                      ),
                                      child: Row(
                                        children: [
                                          Image.network(
                                            _resultIngredients!
                                                .ingredients[index].image,
                                            width: 50 * _scaleScreen,
                                            height: 50 * _scaleScreen,
                                            fit: BoxFit.fill,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8 * _scaleScreen),
                                              child: Text(
                                                _resultIngredients!
                                                    .ingredients[index].name,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppStyle.secondaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.add_circle,
                                            color: AppStyle.gray4Color,
                                            size: 30 * _scaleScreen,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        } else if (snapshot.hasError) {
                          return const Text('no data');
                        }
                        return Center(child: const CircularProgressIndicator());
                      },
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
