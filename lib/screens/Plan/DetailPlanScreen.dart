import 'package:beefit/models/PlamExerciseDetail.dart';
import 'package:beefit/models/plan_details.dart';
import 'package:beefit/widgets/CommonButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/AppMethods.dart';
import '../../constants/AppStyles.dart';
import '../../models/databaseHelper.dart';
import '../../models/plan.dart';
import '../../widgets/TimeLine.dart';
import 'ProcessPlanScreen.dart';

class DetailPlanScreen extends StatefulWidget {
  final Plan _plan;
  DetailPlanScreen({required Plan plan, Key? key})
      : _plan = plan,
        super(key: key);

  @override
  State<DetailPlanScreen> createState() => _DetailPlanScreenState();
}

class _DetailPlanScreenState extends State<DetailPlanScreen> {
  bool isAppbarExpand = true;
  late ScrollController _scrollController;
  List<PlanDetail> listsPlanDetail = [];
  late int maxWeek = 0, maxDay = 0;
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
    double screenHeight = MediaQuery.of(context).size.height;
    final _kAppBarSize = screenHeight * 0.2;
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    late Plan plan = widget._plan;
    DatabaseHelper databaseHelper = DatabaseHelper.instance;

    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      body: FutureBuilder(
        future: Future.wait([
          databaseHelper.getPlanDetailById(widget._plan.id!),
        ]),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          listsPlanDetail = snapshot.data![0] as List<PlanDetail>;
          for (PlanDetail planDetail in listsPlanDetail) {
            if (maxWeek < planDetail.week) maxWeek = planDetail.week;
            if (maxDay < planDetail.day) maxDay = planDetail.day;
          }

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: _kAppBarSize,
                pinned: true,
                elevation: 0.0,
                backgroundColor: AppStyle.primaryColor,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    isAppbarExpand ? "" : plan.name,
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
                          plan.name.toUpperCase(),
                          style: GoogleFonts.poppins(
                            color: AppStyle.whiteColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 28 * _scaleFont,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.clock,
                                    color: AppStyle.whiteColor,
                                    size: 16 * _scaleFont,
                                  ),
                                  SizedBox(width: 4 * _scaleScreen),
                                  Text(
                                    '8-27 minutes/ day',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14 * _scaleFont,
                                      color: AppStyle.whiteColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.calendar,
                                    color: AppStyle.whiteColor,
                                    size: 16 * _scaleFont,
                                  ),
                                  SizedBox(width: 4 * _scaleFont),
                                  Text(
                                    '28 days',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14 * _scaleFont,
                                      color: AppStyle.whiteColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
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
                        children: [
                          Timeline(
                            children: <Widget>[
                              for (int i = 1; i <= maxWeek; i++)
                                WeekContainer(
                                  week: i,
                                  isActive: true,
                                  list: listsPlanDetail
                                      .where((element) => element.week == i)
                                      .toList(),
                                  maxDay: maxDayOfWeek(i),
                                ),
                            ],
                            indicators: <Widget>[
                              for (int i = 0; i < maxWeek; i++) NodeCircle(),
                            ],
                            lineColor: AppStyle.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  int maxDayOfWeek(int week) {
    List<PlanDetail> list =
        listsPlanDetail.where((element) => element.week == week).toList();
    PlanDetail max = list
        .reduce((curr, next) => curr.day > next.day ? curr : next); // 8 --> Max
    PlanDetail min =
        list.reduce((curr, next) => curr.day < next.day ? curr : next);
    return max.day - min.day + 1;
  }
}

class WeekContainer extends StatelessWidget {
  final int _week;
  final bool _isActive;
  final List<PlanDetail> _list;
  final int _maxDayOfWeek;

  const WeekContainer(
      {required int week,
      required bool isActive,
      required List<PlanDetail> list,
      required int maxDay,
      Key? key})
      : _week = week,
        _isActive = isActive,
        _list = list,
        _maxDayOfWeek = maxDay,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double heightGridView = ((screenWidth - 60 - 30 - 24) / 7) * 2 + 12;
    int _no = 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Week $_week",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16 * _scaleScreen,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: AppStyle.appBorder,
            gradient: const LinearGradient(
              colors: [Color(0xffE9A24A), Color(0xffF2BE6A), Color(0xffF6D08B)],
              end: Alignment.bottomRight,
              begin: Alignment.topLeft,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: heightGridView,
                alignment: Alignment.center,
                child: Center(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    // shrinkWrap: true,
                    // primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemCount: _maxDayOfWeek,
                    itemBuilder: (BuildContext context, int index) {
                      return
                          // (0 == ((index % 7) % 2)) ?
                          ButtonCircle(
                        isActive: (!_isActive) ? false : true,
                        no: _no++,
                        list: _list
                            .where((element) => element.day == index + 1)
                            .toList(),
                      );
                      // : const Icon(
                      //     Icons.chevron_right,
                      //     color: AppStyle.whiteColor,
                      //   );
                    },
                  ),
                ),
              ),
              SizedBox(height: _isActive ? 14 * _scaleScreen : 0),
              _isActive
                  ? CommonButton(
                      onPressed: () {},
                      backgroundColor: AppStyle.whiteColor,
                      text: "start".toUpperCase(),
                      textColor: AppStyle.primaryColor,
                      borderRadius: 25,
                      height: 46 * _scaleScreen,
                      elevation: 0,
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}

class NodeCircle extends StatelessWidget {
  const NodeCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 22,
        width: 22,
        decoration: BoxDecoration(
          color: AppStyle.whiteColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppStyle.primaryColor,
            width: 1,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xffE9A24A), Color(0xffF2BE6A), Color(0xffF6D08B)],
              end: Alignment.bottomRight,
              begin: Alignment.topLeft,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonCircle extends StatelessWidget {
  final bool _isActive;
  final int _no;
  final List<PlanDetail> _list;

  const ButtonCircle(
      {required bool isActive,
      required int no,
      required List<PlanDetail> list,
      Key? key})
      : _isActive = isActive,
        _no = no,
        _list = list,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        _no.toString(),
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: _isActive ? AppStyle.primaryColor : AppStyle.whiteColor,
          fontSize: 16,
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DayDetailScreen(
                    day: _list[0].day,
                    planDetail: _list,
                  )),
        );
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(30, 30),
        shape: const CircleBorder(),
        primary: _isActive ? AppStyle.whiteColor : AppStyle.primaryColor,
        elevation: 0,
      ),
    );
  }
}
