
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0XFF121312),
    primaryColor: const Color(0XFFFFBB3B), // yellow
   
    backgroundColor: const Color(0XFF121312),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      selectedLabelStyle: TextStyle(
        color:  Color(0XFFFFBB3B),
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
      unselectedLabelStyle:TextStyle(
        color:  Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ) ,
      type: BottomNavigationBarType.fixed,
      backgroundColor:  Color(0XFF282A28),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedIconTheme: IconThemeData(color:   Color(0XFFFFBB3B), size: 25,),
      unselectedIconTheme: IconThemeData(color: Colors.white, size: 25),
      selectedItemColor: Color(0XFFFFBB3B),
      unselectedItemColor: Colors.white,
    ),

    textTheme: TextTheme(
      displaySmall: GoogleFonts.poppins(
        color: const Color(0XFFB5B4B4),
        fontSize: 8,
        fontWeight: FontWeight.w400,
      ),
      displayMedium: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 12,
      ),
      bodySmall: GoogleFonts.poppins(
        color: const Color(0XFFB5B4B4),
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: const Color(0XFFCBCBCB),
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      displayLarge: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ));
