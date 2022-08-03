import 'dart:async';

import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/models/challenge_detail.dart';
import 'package:beefit/widgets/CommonButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/AppMethods.dart';
import '../../models/PlamExerciseDetail.dart';
import '../../models/User.dart';
import '../../models/defaultReps.dart';
import '../../models/exercise.dart';
import '../Exercise/DetailExerciseScreen.dart';

class PauseChallengeScreen extends StatefulWidget {
  final List<ChallengeDetail> _list;
  final ChallengeDetail _item;
  final DefaultReps _defaultReps;
  final User _user;
  final _index;
  const PauseChallengeScreen({
    Key? key,
    required List<ChallengeDetail> list,
    required ChallengeDetail item,
    required int index,
    required DefaultReps defaultReps,
    required User user,
  })  : _list = list,
        _item = item,
        _index = index,
        _defaultReps = defaultReps,
        _user = user,
        super(key: key);

  @override
  State<PauseChallengeScreen> createState() => _PauseChallengeScreenState();
}

class _PauseChallengeScreenState extends State<PauseChallengeScreen> {
  late Timer _timer;
  late int _start = widget._item.isRep!;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          if (!mounted) return;
          setState(() {
            timer.cancel();
          });
        } else {
          if (!mounted) return;
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    startTimer();
    return Scaffold(
      backgroundColor: AppStyle.primaryColor,
      appBar: AppBar(
        backgroundColor: AppStyle.primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => buildSheet()),
                icon: const Icon(Icons.list),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 30 * _scaleScreen, vertical: 30 * _scaleScreen),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'REST',
                    style: GoogleFonts.poppins(
                        color: AppStyle.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30 * _scaleFont),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '00:${_start}',
                    style: GoogleFonts.poppins(
                        color: AppStyle.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 60 * _scaleFont),
                    textAlign: TextAlign.center,
                  ),
                  CommonButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: AppStyle.whiteColor,
                    text: "SKIP",
                    textColor: AppStyle.primaryColor,
                    elevation: 0,
                    width: 100 * _scaleScreen,
                    height: 40 * _scaleScreen,
                    borderRadius: 30,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Next ${widget._index + 1}/${widget._list.length}',
                  style: GoogleFonts.poppins(
                      color: AppStyle.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18 * _scaleFont),
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    Text(
                      widget._list[widget._index].name!,
                      style: GoogleFonts.poppins(
                          color: AppStyle.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24 * _scaleFont),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () {
                        ChallengeDetail item = widget._list[widget._index];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailExerciseScreen(
                              exercise: Exercise(
                                  name: item.name!,
                                  description: item.des!,
                                  gif: item.gif!,
                                  level: item.level,
                                  type: item.type,
                                  met: item.met,
                                  restDuration: item.duration,
                                  id: item.idExercise,
                                  isRepCount: item.isRep),
                              defaultReps: widget._defaultReps,
                              user: widget._user,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.help_outline,
                        color: AppStyle.whiteColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSheet() {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      snap: false,
      builder: (_, scrollController) => Container(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exercises',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: AppStyle.secondaryColor,
                    fontSize: 24,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel))
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: false,
                primary: true,
                itemBuilder: (context, index) {
                  ChallengeDetail item = widget._list[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailExerciseScreen(
                              exercise: Exercise(
                                  name: item.name!,
                                  description: item.des!,
                                  gif: item.gif!,
                                  level: item.level,
                                  type: item.type,
                                  met: item.met,
                                  restDuration: item.duration,
                                  id: item.idExercise,
                                  isRepCount: item.isRep),
                              defaultReps: widget._defaultReps,
                              user: widget._user,
                            ),
                          ),
                        );
                      },
                      tileColor: AppStyle.gray5Color.withOpacity(0.5),
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
                itemCount: widget._list.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
