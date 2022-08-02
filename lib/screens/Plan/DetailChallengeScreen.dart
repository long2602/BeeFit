import 'package:beefit/models/PlamExerciseDetail.dart';
import 'package:beefit/models/challenge.dart';
import 'package:beefit/models/challenge_detail.dart';
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

class DetailChallengeScreen extends StatefulWidget {
  final Challenge _challenge;
  final User _user;
  const DetailChallengeScreen(
      {required Challenge challenge, required User user, Key? key})
      : _challenge = challenge,
        _user = user,
        super(key: key);

  @override
  State<DetailChallengeScreen> createState() => _DetailChallengeScreenState();
}

class _DetailChallengeScreenState extends State<DetailChallengeScreen> {
  bool isAppbarExpand = true;
  late ScrollController _scrollController;
  List<ChallengeDetail> listsChallengeDetail = [];
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
    late Challenge plan = widget._challenge;
    DatabaseHelper databaseHelper = DatabaseHelper.instance;

    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      body: FutureBuilder(
        future: Future.wait([
          databaseHelper.getChallengeDetailById(
              widget._challenge.id!, widget._user.level!),
        ]),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          listsChallengeDetail = snapshot.data![0] as List<ChallengeDetail>;
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
                            plan.description,
                            style: GoogleFonts.poppins(
                              color: AppStyle.black2Color,
                              fontSize: 14 * _scaleScreen,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Exercises',
                                style: GoogleFonts.poppins(
                                  color: AppStyle.black1Color,
                                  fontSize: 16 * _scaleScreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Total: ${listsChallengeDetail.length}",
                                style: GoogleFonts.poppins(
                                  color: AppStyle.black1Color,
                                  fontSize: 16 * _scaleScreen,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              ChallengeDetail item =
                                  listsChallengeDetail[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6 * _scaleScreen),
                                child: ListTile(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (_) => DetailExerciseScreen(
                                    //       exercise: Exercise(
                                    //           name: item.name,
                                    //           description: item.description,
                                    //           gif: item.gif,
                                    //           level: item.level,
                                    //           type: item.type,
                                    //           met: item.met,
                                    //           restDuration: item.duration,
                                    //           id: item.id,
                                    //           isRepCount: item.isRepCount),
                                    //       defaultReps: defaultReps[0],
                                    //       user: widget._user,
                                    //     ),
                                    //   ),
                                    // );
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
                                    item.name!.toUpperCase(),
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: AppStyle.secondaryColor,
                                      fontSize: 18 * _scaleFont,
                                    ),
                                  ),
                                  subtitle: Text(
                                    item.isRep != 0
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
                            itemCount: listsChallengeDetail.length,
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
}
