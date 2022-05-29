import 'package:beefit/constants/app_style.dart';
import 'package:beefit/constants/app_ui.dart';
import 'package:flutter/material.dart';

import 'ButtonMain.dart';

class OnPageView extends StatefulWidget {
  final String _title;
  final Widget _widget;
  final PageController _pageController;

  const OnPageView(
      {required String title,
      required Widget widget,
      required PageController pageController,
      Key? key})
      : _title = title,
        _widget = widget,
        _pageController = pageController,
        super(key: key);

  @override
  State<OnPageView> createState() => _OnPageViewState();
}

class _OnPageViewState extends State<OnPageView> {
  @override
  Widget build(BuildContext context) {
    final _scale = AppUI.screenScale(context);
    return Container(
      decoration: const BoxDecoration(
        color: AppStyle.whiteColor,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 52 * _scale, vertical: 20 * _scale),
            child: Text(
              widget._title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30 * AppUI.fontScale(context),
                fontWeight: FontWeight.w900,
                color: AppStyle.secondaryColor,
              ),
            ),
          ),
          Expanded(
            child: widget._widget,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                52 * _scale, 20 * _scale, 52 * _scale, 100 * _scale),
            child: ButtonMain(
              backgroundColor: AppStyle.primaryColor,
              textColor: AppStyle.whiteColor,
              text: 'Next',
              height: 60 * AppUI.fontScale(context),
              onPressed: () {
                widget._pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
            ),
          ),
        ],
      ),
    );
  }
}
