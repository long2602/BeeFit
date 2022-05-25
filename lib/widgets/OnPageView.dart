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
    return Container(
      decoration: const BoxDecoration(
        color: AppStyle.whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            widget._title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30 * AppUI.fontScale(context),
              fontWeight: FontWeight.w900,
              color: AppStyle.secondaryColor,
            ),
          ),
          widget._widget,
          ButtonMain(
            backgroundColor: AppStyle.primaryColor,
            textColor: AppStyle.whiteColor,
            text: 'Next',
            onPressed: () {
              widget._pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
          ),
        ],
      ),
    );
  }
}
