import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class CustomTheme with ChangeNotifier {
  CustomTheme._();
  static CustomTheme currentTheme = CustomTheme._();
  static ThemeData get basicTheme {
    return ThemeData(
      fontFamily: 'OpenSans',

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      bannerTheme: const MaterialBannerThemeData(),
      bottomAppBarColor: Colors.black,
      bottomAppBarTheme: const BottomAppBarTheme(),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.black,
        selectedIconTheme: const IconThemeData(),
        unselectedItemColor: Colors.grey[700],
        unselectedIconTheme: const IconThemeData(),
      ),
      bottomSheetTheme: const BottomSheetThemeData(),
      // brightness: Brightness.dark,
      buttonBarTheme: const ButtonBarThemeData(),
      buttonTheme: ButtonThemeData(
        shape: const RoundedRectangleBorder(),
        alignedDropdown: false,
        buttonColor: Colors.white,
        disabledColor: Colors.grey[700],
        highlightColor: Colors.grey[600],
        splashColor: Colors.grey[500],
        focusColor: Colors.grey[400],
        hoverColor: Colors.grey[300],
      ),
      canvasColor: Colors.white,
      cardColor: Colors.black,
      cardTheme: const CardTheme(),
      checkboxTheme: const CheckboxThemeData(),
      chipTheme: const ChipThemeData(
        backgroundColor: Colors.white,
        disabledColor: Colors.grey,
        selectedColor: Colors.white,
        secondarySelectedColor: Colors.white,
        padding: EdgeInsets.all(10),
        labelStyle: TextStyle(),
        secondaryLabelStyle: TextStyle(),
        brightness: Brightness.dark,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xff8496f3),
        primaryContainer: const Color(0xff0e228b),
        secondary: const Color(0xff1739e8),
        secondaryContainer: const Color(0xff0e228b),
        surface: const Color(0xffffffff),
        background: const Color(0xffa2b0f6),
        error: GlorifiColors.red,
        onPrimary: const Color(0xffffffff),
        onSecondary: const Color(0xffffffff),
        onSurface: const Color(0xff000000),
        onBackground: const Color(0xffffffff),
        onError: const Color(0xffffffff),
        brightness: Brightness.dark,
      ),
      cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(),
      dataTableTheme: const DataTableThemeData(),
      dialogBackgroundColor: Colors.black,
      dialogTheme: const DialogTheme(),
      disabledColor: Colors.grey,
      dividerColor: Colors.black,
      dividerTheme: const DividerThemeData(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onSurface: Colors.grey[200],
          padding: const EdgeInsets.all(20),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      errorColor: GlorifiColors.red,
      focusColor: Colors.white,
      highlightColor: Colors.transparent,
      hintColor: Colors.black,
      hoverColor: Colors.transparent,
      iconTheme: const IconThemeData(),
      indicatorColor: Colors.black,
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        helperStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        errorStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        errorMaxLines: null,
        isDense: false,
        contentPadding: EdgeInsets.all(10),
        isCollapsed: false,
        prefixStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        suffixStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        counterStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        filled: true,
        fillColor: Colors.black,
        errorBorder: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: GlorifiColors.bloodOrange,
            width: 3,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        focusedErrorBorder: UnderlineInputBorder(),
        disabledBorder: UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 3,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 3,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
      // materialTapTargetSize: MaterialTapTargetSize.padded,
      navigationRailTheme: const NavigationRailThemeData(),
      outlinedButtonTheme: const OutlinedButtonThemeData(),
      pageTransitionsTheme: const PageTransitionsTheme(),
      popupMenuTheme: const PopupMenuThemeData(),
      primaryColor: Colors.white,
      // ignore: deprecated_member_use
      primaryColorBrightness: Brightness.light,
      primaryColorDark: Colors.black,
      primaryColorLight: Colors.white,
      primaryIconTheme: const IconThemeData(),
      primaryTextTheme: const TextTheme(),
      primarySwatch: const MaterialColor(4286879475, {
        50: Color(0xffe8ebfd),
        100: Color(0xffd1d7fa),
        200: Color(0xffa2b0f6),
        300: Color(0xff7488f1),
        400: Color(0xff4560ed),
        500: Color(0xff1739e8),
        600: Color(0xff122dba),
        700: Color(0xff0e228b),
        800: Color(0xff09175d),
        900: Color(0xff050b2e)
      }),
      progressIndicatorTheme: const ProgressIndicatorThemeData(),
      radioTheme: const RadioThemeData(),
      scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 0.6),
      scrollbarTheme: const ScrollbarThemeData(),
      secondaryHeaderColor: Colors.grey,
      selectedRowColor: Colors.black,
      shadowColor: Colors.black,
      sliderTheme: const SliderThemeData(),
      snackBarTheme: const SnackBarThemeData(),
      splashColor: Colors.transparent,
      tabBarTheme: const TabBarTheme(),
      // textButtonTheme: TextButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     primary: Colors.black,
      //     onPrimary: Colors.white,
      //     shape: const RoundedRectangleBorder(
      //       side: BorderSide(
      //         color: Colors.white,
      //         width: 2,
      //         style: BorderStyle.solid,
      //       ),
      //       borderRadius: BorderRadius.all(Radius.circular(8)),
      //     ),
      //   ),
      // ),
      textSelectionTheme: const TextSelectionThemeData(),
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.transparent,
          fontSize: 34,
          fontFamily: 'univers',
        ),
        headline2: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.transparent,
          fontSize: 18,
          fontFamily: 'univers',
        ),
        headline3: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.transparent,
          fontSize: 18,
          fontFamily: 'univers',
        ),
        headline4: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.transparent,
          fontSize: 18,
          fontFamily: 'univers',
        ),
        headline5: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.transparent,
          fontSize: 18,
          fontFamily: 'univers',
        ),
        headline6: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.transparent,
          fontSize: 18,
          fontFamily: 'univers',
        ),
        subtitle1: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.transparent,
          fontSize: 18,
          fontFamily: 'univers',
        ),
        subtitle2: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.transparent,
          fontSize: 18,
          fontFamily: 'univers',
        ),
        bodyText1: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.transparent,
          fontSize: 13,
          fontFamily: 'univers',
        ),
        bodyText2: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.transparent,
          fontSize: 12,
          fontFamily: 'univers',
        ),
        caption: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.transparent,
          fontSize: 18,
          fontFamily: 'univers',
        ),
        button: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.transparent,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          fontFamily: 'univers',
        ),
        overline: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.transparent,
          fontSize: 18,
          fontFamily: 'univers',
        ),
      ),
      timePickerTheme: const TimePickerThemeData(),
      toggleableActiveColor: Colors.white,
      toggleButtonsTheme: const ToggleButtonsThemeData(),
      tooltipTheme: const TooltipThemeData(),
      unselectedWidgetColor: Colors.grey,
      // visualDensity: const VisualDensity()
    );
  }

  static get styled => null;
}
