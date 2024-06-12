
import 'dart:ui';

import 'package:flutter/material.dart';

int getDifferenceBetweenTwoNumbers(
    {required int firstNumber, required int secondNumber   }) {


  var result  = firstNumber - secondNumber;
  return result.toInt();
}
bool isArabic({required String text}) {
  // Arabic Unicode character ranges
  final arabicRange = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]');
  return arabicRange.hasMatch(text);
}
String convertToDateString(String dateTimeString) {
  // Parse the input string into a DateTime object
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Format the DateTime object to the desired string format
  String formattedDateString = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

  return formattedDateString;
}

double getPercentageDifference(
    {required int currentCarKilometers, required int serviceKilometers, required int lastServiceKilometersMade}) {
  // Calculate kilometers since last gear change
  int kilometersSinceChange = currentCarKilometers - lastServiceKilometersMade;

  // Calculate total coach lifespan
  int coachLifespan = serviceKilometers;

  // Calculate percentage of coach age
  double percentage = (kilometersSinceChange / coachLifespan) * 100;

  // Ensure percentage is within 0-100 range
  if (percentage < 0) {
    percentage = 0;
  } else if (percentage > 100) {
    percentage = 100;
  }

  // Invert the percentage to represent age instead of remaining life
  percentage = 100 - percentage;

  return percentage;

}

Color percentageColor ({required var servicePercentage}){
  return
     servicePercentage == 100.0 ||  servicePercentage >= 50.0 ?Colors.green :servicePercentage < 50.0 && servicePercentage > 0? Colors.yellow: Colors.redAccent;
}

int getDaysBetween({required String fromDate}){
  // Parse the start date string
  DateTime startDate = DateTime.parse(fromDate);
  // Get the current date
  DateTime now = DateTime.now();

  // Set time to midnight for both dates
  startDate = DateTime(startDate.year, startDate.month, startDate.day);
  now = DateTime(now.year, now.month, now.day);

  // Calculate the difference in days
  int differenceInDays = startDate.difference(now).inDays.abs();
  return differenceInDays;
}