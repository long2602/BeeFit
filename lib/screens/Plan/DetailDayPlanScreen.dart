import 'package:beefit/constants/AppMethods.dart';
import 'package:beefit/models/exercise.dart';
import 'package:beefit/models/plan.dart';
import 'package:beefit/screens/Plan/StartPlanScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/AppStyles.dart';
import '../../models/PlamExerciseDetail.dart';
import '../../models/User.dart';
import '../../models/databaseHelper.dart';
import '../../models/defaultReps.dart';
import '../../widgets/CommonButton.dart';
import '../Exercise/DetailExerciseScreen.dart';

class DetailDayPlanScreen extends StatefulWidget {
  final int _day, _week;
  final Plan _plan;
  final User _user;
  const DetailDayPlanScreen(
      {required int day,
      required int week,
      required Plan plan,
      required User user,
      Key? key})
      : _day = day,
        _week = week,
        _plan = plan,
        _user = user,
        super(key: key);

  @override
  _DetailDayPlanScreenState createState() => _DetailDayPlanScreenState();
}

class _DetailDayPlanScreenState extends State<DetailDayPlanScreen> {
  bool isExpand = false;
  bool isAppbarExpand = true;
  late ScrollController _scrollController;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  List<PlanExerciseDetail> planExerciseDetailList = [];
  List<DefaultReps> defaults = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() => _isAppBarExpanded
          ? setState(() {
              isAppbarExpand = false;
            })
          : setState(() {
              isAppbarExpand = true;
            }));
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    double screenHeight = MediaQuery.of(context).size.height;
    final _kAppBarSize = screenHeight * 0.2;
    int day = widget._day;
    double totalCalo = 0;
    double totalTime = 0;
    for (PlanExerciseDetail item in planExerciseDetailList) {
      totalCalo += item.kcal!;
      if (item.isRepCount == 0) {
        totalTime += item.duration! + item.restDuration!;
      } else {
        totalTime += item.rep! + 3 + item.restDuration!;
      }
    }
    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      body: FutureBuilder(
        future: Future.wait([
          databaseHelper.getPlanDayByDay(day, 1, widget._week),
          databaseHelper.getDefaultRepByLevel(widget._user.level!),
        ]),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          planExerciseDetailList =
              snapshot.data![0] as List<PlanExerciseDetail>;
          defaults = snapshot.data![1] as List<DefaultReps>;
          List<DefaultReps> defaultReps = defaults
              .where((element) => element.idBodyPart == widget._user.level)
              .toList();
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: _kAppBarSize,
                pinned: true,
                floating: false,
                elevation: 0.0,
                backgroundColor: AppStyle.primaryColor,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    isAppbarExpand ? "" : widget._plan.name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24 * _scaleFont,
                    ),
                  ),
                  centerTitle: true,
                  background: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 30 * _scaleScreen,
                        vertical: 15 * _scaleScreen),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffE9A24A),
                          Color(0xffF2BE6A),
                          Color(0xffF6D08B)
                        ],
                        end: Alignment.bottomRight,
                        begin: Alignment.topLeft,
                      ),
                      image: DecorationImage(
                        image: AssetImage("assets/imgs/appbarBackground.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget._plan.name,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 24 * _scaleFont,
                          ),
                        ),
                        Text(
                          'Week ${widget._week.toString()} - Day ${day.toString()}'
                              .toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontSize: 30 * _scaleFont,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30 * _scaleScreen,
                          vertical: 20 * _scaleScreen),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      '${(totalTime / 60).ceil()} minutes',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16 * _scaleFont,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.clock,
                                          color: Colors.grey,
                                          size: 14 * _scaleFont,
                                        ),
                                        SizedBox(
                                          width: 4 * _scaleScreen,
                                        ),
                                        Text(
                                          'Time',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13 * _scaleFont,
                                              color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 2,
                                color: Colors.black,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                          color: Colors.black, width: 0.5),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        '$totalCalo kCal',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16 * _scaleFont),
                                      ),
                                      Text(
                                        'Burned',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13 * _scaleScreen,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Exercises (${planExerciseDetailList.length})',
                                  style: TextStyle(fontSize: 16 * _scaleScreen),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              PlanExerciseDetail item =
                                  planExerciseDetailList[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6 * _scaleScreen),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => DetailExerciseScreen(
                                          exercise: Exercise(
                                              name: item.name,
                                              description: item.description,
                                              gif: item.gif,
                                              level: item.level,
                                              type: item.type,
                                              met: item.met,
                                              restDuration: item.duration,
                                              id: item.id,
                                              isRepCount: item.isRepCount),
                                          defaultReps: defaultReps[0],
                                          user: widget._user,
                                        ),
                                      ),
                                    );
                                  },
                                  tileColor:
                                      AppStyle.gray5Color.withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: AppStyle.appBorder,
                                  ),
                                  leading: ClipRRect(
                                    borderRadius: AppStyle.appBorder,
                                    child: Image.asset(
                                      "assets/imgs/exercises/${item.gif}.jpg",
                                      height: 60 * _scaleScreen,
                                      width: 60 * _scaleScreen,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    item.name.toUpperCase(),
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: AppStyle.secondaryColor,
                                      fontSize: 18 * _scaleFont,
                                    ),
                                  ),
                                  subtitle: Text(
                                    item.isRepCount != 0
                                        ? "x${item.rep}"
                                        : "00:${item.duration}",
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 16),
                                ),
                              );
                            },
                            itemCount: planExerciseDetailList.length,
                          ),
                          CommonButton(
                            onPressed: () {
                              Get.to(StartPlanScreen(
                                list: planExerciseDetailList,
                                user: widget._user,
                              ));
                            },
                            backgroundColor: const Color(0xffE4A248),
                            text: 'start'.toUpperCase(),
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
