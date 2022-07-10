import 'package:beefit/constants/AppMethods.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/AppStyles.dart';
import '../tests/data.dart';
import '../tests/model.dart';
import '../widgets/CommonButton.dart';
import 'StartPlanScreen.dart';

class DayDetailScreen extends StatefulWidget {
  final int _day;

  const DayDetailScreen({required int day, Key? key})
      : _day = day,
        super(key: key);

  @override
  _DayDetailScreenState createState() => _DayDetailScreenState();
}

class _DayDetailScreenState extends State<DayDetailScreen> {
  late List<DragAndDropList> lists;
  List<DraggableList> subLists = [];
  bool isExpand = false;
  bool isAppbarExpand = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (allLists[0].items.length > 4) {
      List<DraggableListItem> temps = [];
      temps.add(allLists[0].items[0]);
      temps.add(allLists[0].items[1]);
      temps.add(allLists[0].items[2]);
      temps.add(allLists[0].items[3]);
      DraggableList draggableList = DraggableList(items: temps);
      subLists.add(draggableList);
      lists = subLists.map(buildList).toList();
    } else {
      lists = allLists.map(buildList).toList();
    }

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
    return Scaffold(
      body: CustomScrollView(
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
                isAppbarExpand ? "" : "Massive upper body",
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
                    horizontal: 30 * _scaleScreen, vertical: 15 * _scaleScreen),
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
                      'Massive upper body',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 24 * _scaleFont,
                      ),
                    ),
                    Text(
                      'Day ${day.toString()}'.toUpperCase(),
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
                                  '17 minutes',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16 * _scaleFont,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    '100 kCal',
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
                            const Text(
                              'Exercises (10)',
                              style: TextStyle(fontSize: 16),
                            ),
                            subLists.isNotEmpty
                                ? TextButton(
                                    onPressed: () {
                                      setState(() {
                                        if (!isExpand) {
                                          lists =
                                              allLists.map(buildList).toList();
                                          isExpand = true;
                                        } else {
                                          lists =
                                              subLists.map(buildList).toList();
                                          isExpand = false;
                                        }
                                      });
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          isExpand ? 'Hide' : 'Show',
                                          style: const TextStyle(
                                              color: Color(0xffE4A248)),
                                        ),
                                        Icon(
                                          isExpand
                                              ? Icons.expand_less
                                              : Icons.expand_more,
                                          color: const Color(0xffE4A248),
                                        ),
                                      ],
                                    ))
                                : Container(),
                          ],
                        ),
                      ),
                      DragAndDropLists(
                        lastListTargetSize: 10,
                        disableScrolling: true,
                        listPadding: EdgeInsets.zero,
                        listInnerDecoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        children: lists,
                        itemDivider: const Divider(
                          thickness: 1,
                          height: 1,
                          color: Colors.grey,
                          indent: 40,
                        ),
                        itemDecorationWhileDragging: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4)
                          ],
                        ),
                        itemDragHandle: buildDragHandle(),
                        onItemReorder: onReorderListItem,
                        onListReorder: onReorderList,
                      ),
                      CommonButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StartPlan()),
                          );
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
      ),
    );
  }

  DragHandle buildDragHandle({bool isList = false}) {
    final verticalAlignment = isList
        ? DragHandleVerticalAlignment.top
        : DragHandleVerticalAlignment.center;
    final color = isList ? Colors.blueGrey : Colors.black26;

    return DragHandle(
      onLeft: true,
      verticalAlignment: verticalAlignment,
      child: const Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: Icon(Icons.menu, color: Colors.black26),
      ),
    );
  }

  DragAndDropList buildList(DraggableList list) {
    return DragAndDropList(
      children: list.items.map((item) {
        return DragAndDropItem(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.menu, color: Colors.black26),
                ),
                Expanded(
                  child: ListTile(
                    onTap: () => showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => buildSheet(item)),
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        item.urlImage,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          '00:20',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  void onReorderListItem(
    int oldItemIndex,
    int oldListIndex,
    int newItemIndex,
    int newListIndex,
  ) {
    setState(() {
      final oldListItems = lists[oldListIndex].children;
      final newListItems = lists[newListIndex].children;

      final movedItem = oldListItems.removeAt(oldItemIndex);
      newListItems.insert(newItemIndex, movedItem);
    });
  }

  void onReorderList(
    int oldListIndex,
    int newListIndex,
  ) {
    setState(() {
      final movedList = lists.removeAt(oldListIndex);
      lists.insert(newListIndex, movedList);
    });
  }

  Widget buildSheet(DraggableListItem item) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              width: 80,
              height: 4,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item.urlImage,
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              item.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Performing hot reload...Syncing files to device Android SDK built for x86...Reloaded 1 of 607 libraries in 687ms.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Expanded(child: Container()),
          CommonButton(
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: const Color(0xffE4A248),
            text: 'Close'.toUpperCase(),
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
