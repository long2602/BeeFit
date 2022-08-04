import 'package:beefit/models/PlanExerciseDetail.dart';
import 'package:beefit/models/plan_details.dart';
import 'package:beefit/widgets/CommonButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/AppMethods.dart';
import '../../constants/AppStyles.dart';
import '../../models/User.dart';
import '../../models/databaseHelper.dart';
import '../../models/plan.dart';
import '../../widgets/TimeLine.dart';
import 'DetailDayPlanScreen.dart';

class DetailPlanScreen extends StatefulWidget {
  final Plan _plan;
  final User _user;
  const DetailPlanScreen({required Plan plan, required User user, Key? key})
      : _plan = plan,
        _user = user,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: GoogleFonts.poppins(
                              color: AppStyle.black1Color,
                              fontSize: 16 * _scaleScreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            plan.des,
                            style: GoogleFonts.poppins(
                              color: AppStyle.black2Color,
                              fontSize: 14 * _scaleScreen,
                            ),
                          ),
                          Timeline(
                            children: <Widget>[
                              for (int i = 1; i <= maxWeek; i++)
                                FutureBuilder(
                                  future:
                                      databaseHelper.getPlanDetailByIdAndWeek(
                                          widget._plan.id!, i),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                    List<PlanDetail> _list =
                                        snapshot.data as List<PlanDetail>;
                                    return WeekContainer(
                                      week: i,
                                      isActive: true,
                                      list: _list,
                                      maxDay: maxDayOfWeek(i),
                                      plan: plan,
                                      user: widget._user,
                                      databaseHelper: databaseHelper,
                                    );
                                  },
                                )
                            ],
                            indicators: <Widget>[
                              for (int i = 0; i < maxWeek; i++)
                                const NodeCircle(),
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
  final Plan _plan;
  final User _user;
  final DatabaseHelper _databaseHelper;

  const WeekContainer(
      {required int week,
      required bool isActive,
      required List<PlanDetail> list,
      required int maxDay,
      required Plan plan,
      required User user,
      required DatabaseHelper databaseHelper,
      Key? key})
      : _week = week,
        _isActive = isActive,
        _list = list,
        _maxDayOfWeek = maxDay,
        _plan = plan,
        _user = user,
        _databaseHelper = databaseHelper,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double heightGridView = ((screenWidth - 60 - 30 - 24) / 7) * 2 + 12;
    int _no = 1;
    print("$_week $_list");
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
              Wrap(
                children: [
                  for (int i = 0; i < _maxDayOfWeek; i++)
                    FutureBuilder(
                      future: _databaseHelper.getStatusPlan(
                          _plan.id!, _week, i + 1),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: AppStyle.primaryColor,
                          ));
                        }
                        bool isDone = snapshot.data as bool;
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ButtonCircle(
                              isActive: isDone,
                              no: i + 1,
                              week: _week,
                              plan: _plan,
                              user: _user,
                            ),
                            i != (_maxDayOfWeek - 1)
                                ? const Icon(Icons.arrow_forward_ios,
                                    color: AppStyle.whiteColor)
                                : Container(),
                          ],
                        );
                      },
                    )
                ],
              ),
              // SizedBox(height: _isActive ? 14 * _scaleScreen : 0),
              // _isActive
              //     ? CommonButton(
              //         onPressed: () {},
              //         backgroundColor: AppStyle.whiteColor,
              //         text: "start".toUpperCase(),
              //         textColor: AppStyle.primaryColor,
              //         borderRadius: 25,
              //         height: 46 * _scaleScreen,
              //         elevation: 0,
              //       )
              //     : Container(),
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
  final int _week;
  final Plan _plan;
  final User _user;

  const ButtonCircle(
      {required bool isActive,
      required int no,
      required int week,
      required Plan plan,
      required User user,
      Key? key})
      : _isActive = isActive,
        _no = no,
        _week = week,
        _plan = plan,
        _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: !_isActive
          ? Text(
              _no.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: AppStyle.primaryColor,
                fontSize: 16,
              ),
            )
          : const Icon(Icons.check),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailDayPlanScreen(
                  day: _no, week: _week, plan: _plan, user: _user)),
        );
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(30, 30),
        shape: const CircleBorder(),
        primary: !_isActive ? AppStyle.whiteColor : AppStyle.primaryColor,
        elevation: 0,
      ),
    );
  }
}
