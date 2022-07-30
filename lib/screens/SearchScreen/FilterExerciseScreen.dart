import 'package:beefit/constants/AppStyles.dart';
import 'package:beefit/screens/SearchScreen/ResultFilterScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/AppMethods.dart';
import '../../widgets/CommonButton.dart';

class FilterExerciseScreen extends StatefulWidget {
  const FilterExerciseScreen({Key? key}) : super(key: key);

  @override
  State<FilterExerciseScreen> createState() => _FilterExerciseScreenState();
}

class _FilterExerciseScreenState extends State<FilterExerciseScreen> {
  bool _isArm = false,
      _isChest = false,
      _isAbs = false,
      _isButt = false,
      _isLeg = false,
      _isFullBody = false,
      _isShoulder = false,
      _isBack = false,
      _isWarmUp = false,
      _isMain = false,
      _isStretch = false,
      _isBeginner = false,
      _isInter = false,
      _isAdvanced = false;
  List<int> categories = [];
  List<int> types = [];
  List<int> levels = [];

  optionFilter(bool _isSelected, int value, List<int> lists) {
    if (_isSelected) {
      lists.add(value);
    } else {
      if (lists.contains(value)) {
        lists.remove(value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _scaleFont = AppMethods.fontScale(context);
    final _scaleScreen = AppMethods.screenScale(context);
    return Scaffold(
      backgroundColor: AppStyle.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyle.primaryColor,
        title: Text(
          'Filter',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: AppStyle.whiteColor,
            fontSize: 24 * _scaleFont,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: AppStyle.secondaryColor,
                        fontSize: 18 * _scaleFont,
                      ),
                    ),
                    Wrap(
                      runSpacing: 3.0,
                      spacing: 5.0,
                      children: [
                        FilterChip(
                          label: const Text('Arm'),
                          labelStyle: GoogleFonts.poppins(
                            color: _isArm
                                ? AppStyle.whiteColor
                                : AppStyle.secondaryColor,
                            fontSize: 16.0,
                          ),
                          selected: _isArm,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: AppStyle.gray5Color,
                          onSelected: (isSelected) {
                            setState(() {
                              _isArm = isSelected;
                              optionFilter(_isArm, 1, categories);
                            });
                          },
                          selectedColor: AppStyle.primaryColor,
                        ),
                        FilterChip(
                          label: const Text('Chest'),
                          labelStyle: GoogleFonts.poppins(
                            color: _isChest
                                ? AppStyle.whiteColor
                                : AppStyle.secondaryColor,
                            fontSize: 16.0,
                          ),
                          selected: _isChest,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: AppStyle.gray5Color,
                          onSelected: (isSelected) {
                            setState(() {
                              _isChest = isSelected;
                              optionFilter(_isChest, 2, categories);
                            });
                          },
                          selectedColor: AppStyle.primaryColor,
                        ),
                        FilterChip(
                          label: const Text('Abs'),
                          labelStyle: GoogleFonts.poppins(
                            color: _isAbs
                                ? AppStyle.whiteColor
                                : AppStyle.secondaryColor,
                            fontSize: 16.0,
                          ),
                          selected: _isAbs,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: AppStyle.gray5Color,
                          onSelected: (isSelected) {
                            setState(() {
                              _isAbs = isSelected;
                              optionFilter(_isAbs, 3, categories);
                            });
                          },
                          selectedColor: AppStyle.primaryColor,
                        ),
                        FilterChip(
                          label: const Text('Butt'),
                          labelStyle: GoogleFonts.poppins(
                            color: _isButt
                                ? AppStyle.whiteColor
                                : AppStyle.secondaryColor,
                            fontSize: 16.0,
                          ),
                          selected: _isButt,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: AppStyle.gray5Color,
                          onSelected: (isSelected) {
                            setState(() {
                              _isButt = isSelected;
                              optionFilter(_isButt, 4, categories);
                            });
                          },
                          selectedColor: AppStyle.primaryColor,
                        ),
                        FilterChip(
                          label: const Text('Leg'),
                          labelStyle: GoogleFonts.poppins(
                            color: _isLeg
                                ? AppStyle.whiteColor
                                : AppStyle.secondaryColor,
                            fontSize: 16.0,
                          ),
                          selected: _isLeg,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: AppStyle.gray5Color,
                          onSelected: (isSelected) {
                            setState(() {
                              _isLeg = isSelected;
                              optionFilter(_isLeg, 5, categories);
                            });
                          },
                          selectedColor: AppStyle.primaryColor,
                        ),
                        FilterChip(
                          label: const Text('FullBody'),
                          labelStyle: GoogleFonts.poppins(
                            color: _isFullBody
                                ? AppStyle.whiteColor
                                : AppStyle.secondaryColor,
                            fontSize: 16.0,
                          ),
                          selected: _isFullBody,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: AppStyle.gray5Color,
                          onSelected: (isSelected) {
                            setState(() {
                              _isFullBody = isSelected;
                              optionFilter(_isFullBody, 6, categories);
                            });
                          },
                          selectedColor: AppStyle.primaryColor,
                        ),
                        FilterChip(
                          label: const Text('Shoulder'),
                          labelStyle: GoogleFonts.poppins(
                            color: _isShoulder
                                ? AppStyle.whiteColor
                                : AppStyle.secondaryColor,
                            fontSize: 16.0,
                          ),
                          selected: _isShoulder,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: AppStyle.gray5Color,
                          onSelected: (isSelected) {
                            setState(() {
                              _isShoulder = isSelected;
                              optionFilter(_isShoulder, 7, categories);
                            });
                          },
                          selectedColor: AppStyle.primaryColor,
                        ),
                        FilterChip(
                          label: const Text('Back'),
                          labelStyle: GoogleFonts.poppins(
                            color: _isBack
                                ? AppStyle.whiteColor
                                : AppStyle.secondaryColor,
                            fontSize: 16.0,
                          ),
                          selected: _isBack,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: AppStyle.gray5Color,
                          onSelected: (isSelected) {
                            setState(() {
                              _isBack = isSelected;
                              optionFilter(_isBack, 8, categories);
                            });
                          },
                          selectedColor: AppStyle.primaryColor,
                        ),
                      ],
                    ),
                    const Divider(),
                    Text(
                      'Type',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: AppStyle.secondaryColor,
                        fontSize: 18 * _scaleFont,
                      ),
                    ),
                    Wrap(
                      runSpacing: 3.0,
                      spacing: 5.0,
                      children: [
                        FilterChip(
                          label: const Text('Warm up'),
                          labelStyle: GoogleFonts.poppins(
                            color: _isWarmUp
                                ? AppStyle.whiteColor
                                : AppStyle.secondaryColor,
                            fontSize: 16.0,
                          ),
                          selected: _isWarmUp,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: AppStyle.gray5Color,
                          onSelected: (isSelected) {
                            setState(() {
                              _isWarmUp = isSelected;
                              optionFilter(_isWarmUp, 1, types);
                            });
                          },
                          selectedColor: AppStyle.primaryColor,
                        ),
                        FilterChip(
                          label: const Text('Main exercise'),
                          labelStyle: GoogleFonts.poppins(
                            color: _isMain
                                ? AppStyle.whiteColor
                                : AppStyle.secondaryColor,
                            fontSize: 16.0,
                          ),
                          selected: _isMain,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: AppStyle.gray5Color,
                          onSelected: (isSelected) {
                            setState(() {
                              _isMain = isSelected;
                              optionFilter(_isMain, 2, types);
                            });
                          },
                          selectedColor: AppStyle.primaryColor,
                        ),
                        FilterChip(
                          label: const Text('Stretch'),
                          labelStyle: GoogleFonts.poppins(
                            color: _isStretch
                                ? AppStyle.whiteColor
                                : AppStyle.secondaryColor,
                            fontSize: 16.0,
                          ),
                          selected: _isStretch,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: AppStyle.gray5Color,
                          onSelected: (isSelected) {
                            setState(() {
                              _isStretch = isSelected;
                              optionFilter(_isStretch, 3, types);
                            });
                          },
                          selectedColor: AppStyle.primaryColor,
                        ),
                      ],
                    ),
                    const Divider(),
                    Text(
                      'Level',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: AppStyle.secondaryColor,
                        fontSize: 18 * _scaleFont,
                      ),
                    ),
                    Wrap(
                      runSpacing: 3.0,
                      spacing: 5.0,
                      children: [
                        FilterChip(
                          label: const Text('Beginner'),
                          labelStyle: GoogleFonts.poppins(
                            color: _isBeginner
                                ? AppStyle.whiteColor
                                : AppStyle.secondaryColor,
                            fontSize: 16.0,
                          ),
                          selected: _isBeginner,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: AppStyle.gray5Color,
                          onSelected: (isSelected) {
                            setState(() {
                              _isBeginner = isSelected;
                              optionFilter(_isBeginner, 1, levels);
                            });
                          },
                          selectedColor: AppStyle.primaryColor,
                        ),
                        FilterChip(
                          label: const Text('Intermediate'),
                          labelStyle: GoogleFonts.poppins(
                            color: _isInter
                                ? AppStyle.whiteColor
                                : AppStyle.secondaryColor,
                            fontSize: 16.0,
                          ),
                          selected: _isInter,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: AppStyle.gray5Color,
                          onSelected: (isSelected) {
                            setState(() {
                              _isInter = isSelected;
                              optionFilter(_isMain, 2, levels);
                            });
                          },
                          selectedColor: AppStyle.primaryColor,
                        ),
                        FilterChip(
                          label: const Text('Advanced'),
                          labelStyle: GoogleFonts.poppins(
                            color: _isAdvanced
                                ? AppStyle.whiteColor
                                : AppStyle.secondaryColor,
                            fontSize: 16.0,
                          ),
                          selected: _isAdvanced,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: AppStyle.gray5Color,
                          onSelected: (isSelected) {
                            setState(() {
                              _isAdvanced = isSelected;
                              optionFilter(_isAdvanced, 3, levels);
                            });
                          },
                          selectedColor: AppStyle.primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CommonButton(
              elevation: 0,
              width: double.infinity,
              backgroundColor: AppStyle.primaryColor,
              textColor: AppStyle.whiteColor,
              text: 'Apply',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResultFilterScreen(
                      categories: categories,
                      levels: levels,
                      types: types,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
