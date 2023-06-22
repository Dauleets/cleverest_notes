import 'package:flutter/material.dart';

import 'colors.dart';

class Styles {
  static ThemeData themeData(BuildContext context) {
    return ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: AppColors.colorGreen,
        shadowColor: AppColors.cardColor,
        scaffoldBackgroundColor: AppColors.colorWhite,
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.colorGreen),
        textTheme: TextThemes.textTheme(context),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 0,
          backgroundColor: AppColors.colorWhite,
        ),
        listTileTheme: ListTileThemeData(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          tileColor: AppColors.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          horizontalTitleGap: 10,
          minVerticalPadding: 10,
          minLeadingWidth: 0,
          dense: false,
          visualDensity: VisualDensity.standard,
        ));
  }
}

class TextThemes {
  static TextTheme textTheme(BuildContext context) {
    return Theme.of(context).textTheme.copyWith(
          displayLarge: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.colorWhite,
          ),
          displayMedium: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.colorBlack,
          ),
          displaySmall: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.colorBlack,
          ),
        );
  }
}
