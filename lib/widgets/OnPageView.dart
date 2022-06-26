import 'package:beefit/constants/AppMethods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/AppStyles.dart';
import 'ButtonMain.dart';

class OnPageView extends StatefulWidget {
  final String _title;
  final Widget _widget;
  final String _keyword;
  final String _additionalText;
  final PageController _pageController;
  final VoidCallback? _onPressed;
  final bool _canPress;

  const OnPageView(
      {required String title,
      required Widget widget,
      required String keyword,
      required String additionalText,
      required PageController pageController,
      VoidCallback? onPressed,
      required bool canPress,
      Key? key})
      : _title = title,
        _widget = widget,
        _keyword = keyword,
        _pageController = pageController,
        _onPressed = onPressed,
        _additionalText = additionalText,
        _canPress = canPress,
        super(key: key);

  @override
  State<OnPageView> createState() => _OnPageViewState();
}

class _OnPageViewState extends State<OnPageView> {
  @override
  Widget build(BuildContext context) {
    final _scale = AppMethods.screenScale(context);
    return Container(
      decoration: const BoxDecoration(
        color: AppStyle.whiteColor,
      ),
      child: Column(
        children: [
          SizedBox(height: 70 * _scale),
          Padding(
            padding: EdgeInsets.only(left: 30 * _scale, right: 30 * _scale),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25 * AppMethods.fontScale(context)),
                    children: [
                      TextSpan(text: widget._title),
                      TextSpan(
                          text: widget._keyword,
                          style: TextStyle(
                              color: Color(AppMethods.hexColor("#fb9b28")),
                              fontWeight: FontWeight.bold)),
                      TextSpan(text: widget._additionalText)
                    ])),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(30), child: widget._widget),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 50),
            child: ButtonMain(
              backgroundColor: widget._canPress == true
                  ? Color(AppMethods.hexColor("#fb9b28"))
                  : Colors.grey.shade400,
              textColor: AppStyle.whiteColor,
              text: 'Next',
              height: 50 * AppMethods.fontScale(context),
              onPressed: widget._onPressed == null
                  ? widget._canPress == true
                      ? () {
                          widget._pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        }
                      : () {
                          Get.snackbar(
                            "Please choose your gender!",
                            "You did not choose your gender. Please choose one to continue.",
                            dismissDirection: DismissDirection.horizontal,
                            colorText: Colors.white,
                            snackStyle: SnackStyle.FLOATING,
                            barBlur: 30,
                            backgroundColor: Colors.black54,
                            isDismissible: true,
                            duration: const Duration(seconds: 3),
                          );
                        }
                  : widget._onPressed!,
            ),
          ),
        ],
      ),
    );
  }
}
