import 'package:flutter/material.dart';


class AppTheme {

  AppTheme._();
  static final ThemeData lightTheme =  ThemeData(

    brightness: Brightness.light,
    primaryColor: Colors.grey[100],
    // primaryColor: Colors.white,
    backgroundColor: Colors.grey[100],
    hintColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
          fontWeight: FontWeight.w400
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.grey[800],
         fontFamily: 'IBM' ,
        fontSize: 18,
          fontWeight: FontWeight.w400
        // fontWeight: FontWeight.bold,
      ),
      // headline6: TextStyle(
      //   color: Colors.black,
      //   fontFamily: 'IBM' ,
      //   fontSize: 18,
      //     fontWeight: FontWeight.w400
      // ),
      // bodyText2: TextStyle(
      //   color: Colors.black,
      //   fontSize: 16,
      //     fontWeight: FontWeight.w400
      // ),
    ),

  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: Colors.grey[900],

    primaryColor: Colors.grey[900],
    hintColor:  Colors.grey[900],
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(

      backgroundColor: Colors.grey[900],
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'IBM',
        color: Colors.white,
        fontSize: 20,
          fontWeight: FontWeight.w400
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'IBM' ,
          fontWeight: FontWeight.w400
      ),
      // headline6: TextStyle(
      //   color: Colors.white,
      //   fontSize: 18,
      //   fontFamily: 'IBM' ,
      //     fontWeight: FontWeight.w400
      // ),
      //
      // bodyText2: TextStyle(
      //   color: Colors.white,
      //   fontSize: 16,
      //   fontFamily: 'IBM' ,
      //     fontWeight: FontWeight.w400
      //
      // ),
    ),
  );
}


// custom Theme
// Theme Colors
Color primaryColor = const Color(0xffff9800);
Color secondaryColor = const Color(0xFF15afff);

// Theme Palette
Color whiteColor = const Color(0xFFffffff);
Color greenColor = const Color(0xFF4caf50);
Color redColor = const Color(0xFFf44336);
Color orangeColor = const Color(0xFFff9800);
Color yellowColor = const Color(0xFFffc107);
Color pinkColor = const Color(0xFFec407a);
Color purpleColor = const Color(0xFFab47bc);
Color blueColor = const Color(0xFF15afff);
Color indigoColor = const Color(0xFF3f51b5);
Color blackColor = const Color(0xFF000000);

// Theme bg colors
Color bgColor = const Color(0xFF212332);
Color bgColorLight = const Color(0xFF2A2D3E);

// Theme Grey Shades
Color greyLighter = const Color(0xfffafafa);
Color greyLight = const Color(0xFFd5d5d5);
Color greyDefault = const Color(0xFF94959b);
Color greyDark = const Color(0xFF727272);

// Theme Text Color
Color textWhiteGrey = const Color(0xfffafafa);
Color textGrey = const Color(0xFF94959b);
Color textBlack = const Color(0xFF333333);

// Theme Spacing
const smallSpacing = 8.0;
const defaultSpacing = 16.0;
const mediumSpacing = 24.0;
const largeSpacing = 32.0;

// Theme Text Styles
TextStyle regularBody12 = TextStyle(
  color: greyDefault,
  fontSize: 12,
  fontWeight: FontWeight.w400,
);

TextStyle regularBody = TextStyle(
  color: greyDefault,
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

TextStyle regularBody16 = TextStyle(
  color: greyDefault,
  fontSize: 16,
  fontWeight: FontWeight.w400,
  height: 1.8,
);

TextStyle heading1 = TextStyle(
  color: indigoColor,
  fontWeight: FontWeight.w700,
  fontSize: 24,
);

TextStyle heading2 = TextStyle(
  color: textWhiteGrey,
  fontWeight: FontWeight.w700,
  fontSize: 20,
);

TextStyle heading3 = TextStyle(
  color: indigoColor,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

TextStyle heading4 = TextStyle(
  color: indigoColor,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

/* Theme Blocks Styles */
BoxDecoration labelStyles = BoxDecoration(
  color: greenColor.withOpacity(.5),
  border: Border.all(
    color: greenColor,
    width: 1.0,
  ),
  borderRadius: BorderRadius.circular(3),
);

BoxDecoration labelDanger = BoxDecoration(
  color: redColor.withOpacity(.5),
  border: Border.all(
    color: redColor,
    width: 1.0,
  ),
  borderRadius: BorderRadius.circular(3),
);

/*
class MyTheme {
  static ThemeData get theme {
    return ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.dark,
      primaryColor: Colors.lightBlue[800],

      // Define the default font family.
      fontFamily: 'Georgia',

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: constants TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    );
  }
}
*/


